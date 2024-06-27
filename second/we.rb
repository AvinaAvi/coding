

# This class handles API requests
class APIHandler
  def initialize
    @api_key = "ABCD-1234-XYZ"  # Hardcoded API key
  end

  def fetch_data
    puts "Using API Key: #{@api_key}"
    # Simulated API request logic...
    # This code assumes that the API key is valid and does not handle changes or security issues.
  end
end

# Main execution block
api_handler = APIHandler.new
api_handler.fetch_data

