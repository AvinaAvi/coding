require 'logger'

# Create a logger that outputs to a file
logger = Logger.new('application.log')

# Set the logger level to DEBUG to capture all messages
logger.level = Logger::DEBUG

# Using the logger for debugging
speed = 100
time = 20
logger.debug("Speed=#{speed}, Time=#{time}")

# Additional operational log
logger.info("Application started successfully")

# Handling errors with logging
begin
  # Hypothetical method that might raise an exception
  risky_operation()
rescue StandardError => e
  logger.error("Error occurred: #{e.message}")
end
