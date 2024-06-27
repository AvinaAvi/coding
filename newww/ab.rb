# Represents a basic Book class with title and author attributes
class Book
  attr_reader :title, :author

  # Initializes a new Book instance with given title and author
  # @param [String] title The title of the book
  # @param [String] author The author of the book
  def initialize(title, author)
    @title = title
    @author = author
  end

  # Returns a formatted string representing the book details
  # @return [String] Formatted string with book title and author
  def info
    "#{@title} by #{@author}"
  end
end

# Example usage:
book = Book.new("Ruby Programming", "John Doe")
puts "Book details: #{book.info}"