

# File: example_script.rb
# This file contains methods demonstrating proper error and exception handling practices.

module DataProcessor
  # Processes data from a file and handles potential errors gracefully.
  def self.process_file(file_path)
    begin
      # Attempt to read the file
      data = File.read(file_path)
      # Simulate processing data
      process_data(data)
      return true # normal return
    rescue Errno::ENOENT => e
      # Handle file not found error
      logger.error "File not found: #{e}"
      return false # error return
    rescue StandardError => e
      # Handle other standard errors
      logger.error "An error occurred while processing the file: #{e}"
      return false # error return
    end
  end

  # Simulate data processing method
  def self.process_data(data)
    # Process data
    puts "Processing data: #{data}"
  end

  # Logger method for simplicity
  def self.logger
    @logger ||= Logger.new($stdout)
  end
end

# Main script execution
if __FILE__ == $0
  file_path = 'data.txt'
  success = DataProcessor.process_file(file_path)
  unless success
    puts "Failed to process the file. Check logs for details."
  end
end
