


# This Ruby script demonstrates basic database operations using the SQLite3 gem.
# It includes functions to create a database table, insert data, and query data,
# all while adhering to best practices for not hardcoding sensitive or specific information.

require 'sqlite3'
require 'yaml'

# Load database configuration from an external YAML file specified by an environment variable
config_path = ENV['DB_CONFIG_PATH']
config = YAML.load_file(config_path) if File.exist?(config_path)
db_path = config['database_path'] || 'example.db'  # Fallback to default if not specified

# Initialize a new SQLite database
DB = SQLite3::Database.new(db_path)

# Function to create a table in the database
def create_table
  query = <<-SQL
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE
    );
  SQL
  DB.execute(query)
  puts "Table 'users' created or already exists."
end

# Function to insert a new user into the database. Uses placeholders (?, ?) to prevent SQL injection.
# In case of exception (e.g. violation of the unique constraint on the email), it rescues and prints an error message.
def insert_user(name, email)
  query = "INSERT INTO users (name, email) VALUES (?, ?)"
  DB.execute(query, [name, email])
  puts "User #{name} added to the database."
rescue SQLite3::Exception => e
  puts "An error occurred while inserting data: #{e.message}"
end

# Function to query all users from the database
def fetch_users
  query = "SELECT id, name, email FROM users"
  results = DB.execute(query)
  puts "Listing all users:"
  results.each do |row|
    puts "ID: #{row[0]}, Name: #{row[1]}, Email: #{row[2]}"
  end
end

# Main script execution to demonstrate database functions
begin
  create_table
  insert_user("John Doe", "john.doe@example.com")
  insert_user("Jane Smith", "jane.smith@example.com")
  fetch_users
rescue SQLite3::Exception => e
  puts "Database error: #{e.message}"
rescue StandardError => e
  puts "General error: #{e.message}"
ensure
  DB.close if DB
end

