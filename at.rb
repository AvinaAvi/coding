module DataProcessor
  def self.process_file(file_path)
    begin
      # Attempt to read the file
      data = File.read(file_path)
      # Simulate processing data
      process_data(data)
      return true 
    rescue Errno::ENOENT
      # Handle file not found error without logging
      puts "File not found"
      return false # error return
    rescue StandardError
      # Handle other standard errors without logging
      puts "An error occurred while processing the file"
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


