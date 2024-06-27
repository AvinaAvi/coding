
require 'sinatra'
require 'logger'

# Initialize Logger
logger = Logger.new(STDOUT)
logger.level = Logger::DEBUG

# Before filter to log each request
before do
  logger.info("Received request on #{request.path_info} from #{request.ip}")
end

get '/' do
  logger.debug("Loading home page")
  "Welcome to the Home Page"
end

get '/about' do
  logger.debug("Loading about page")
  "About Us"
end

error 404 do
  logger.error("Page not found: #{request.path_info}")
  "404 - Page Not Found"
end

error 500 do
  message = "Internal server error: #{env['sinatra.error'].message}"
  logger.fatal(message)
  message
end



