require 'yaml'

#Loading database credentials from environment variables
db_username = ENV['DB_USERNAME']
db_password = ENV['DB_PASSWORD']

# Loading the configuration path from an environment variable and reading the configuration file
# This allows for flexible deployment environments and easier configuration management
config_file_path = ENV['CONFIG_FILE_PATH']
config = YAML.load_file(config_file_path)  # Load configuration settings from YAML file

# Retrieving the API URL from the loaded configuration to keep the URL manageable via external configuration
api_url = config['api_url']

puts "Database credentials: #{db_username}, #{db_password}"
puts "API URL: #{api_url}"