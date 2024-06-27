

# This Ruby script demonstrates managing a contact list using a SQLite database.
# It adheres to coding standards by using environment variables for database configuration and by including detailed comments to describe each function and its operations.

require 'sqlite3'
require 'yaml'

# Load database configuration from an external YAML file specified by an environment variable.
# This approach avoids hardcoding sensitive configuration details directly in the script.
config_path = ENV['CONTACTS_DB_CONFIG']
if File.exist?(config_path)
  config = YAML.load_file(config_path)
  db_path = config['database_path']
else
  raise "Database configuration file missing."
end

# Initialize a new SQLite database with the path retrieved from the configuration file.
DB = SQLite3::Database.new(db_path)

# Function to create a contacts table in the database if it does not already exist.
# This helps ensure that the script can operate independently of the database's initial state.
def create_contacts_table
  query = <<-SQL
    CREATE TABLE IF NOT EXISTS contacts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      phone_number TEXT NOT NULL,
      email TEXT UNIQUE
    );
  SQL
  DB.execute(query)
  puts "Contacts table created or already exists."
end

# Function to add a new contact to the contacts table.
# Uses parameterized queries to avoid SQL injection.
def add_contact(name, phone_number, email)
  query = "INSERT INTO contacts (name, phone_number, email) VALUES (?, ?, ?)"
  DB.execute(query, [name, phone_number, email])
  puts "Contact added: #{name}"
rescue SQLite3::Exception => e
  puts "Error adding contact: #{e.message}"
end

# Function to list all contacts in the contacts table.
# Fetches and displays each contact's details.
def list_contacts
  query = "SELECT id, name, phone_number, email FROM contacts"
  results = DB.execute(query)
  puts "Contacts list:"
  results.each do |contact|
    puts "ID: #{contact[0]}, Name: #{contact[1]}, Phone: #{contact[2]}, Email: #{contact[3]}"
  end
end

# Main execution block to demonstrate functionality.
begin
  create_contacts_table
  add_contact("Alice Johnson", "123-456-7890", "alice@example.com")
  add_contact("Bob Smith", "987-654-3210", "bob@example.com")
  list_contacts
rescue StandardError => e
  puts "An unexpected error occurred: #{e.message}"
ensure
  DB.close if DB
end
