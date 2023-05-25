require 'json'

class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def add_rental(rental)
    return if rentals.include?(rental)

    rentals << rental
    rental.book = self
  end

  def to_json(*args)
    {
      'title' => title,
      'author' => author
    }.to_json(*args)
  end
end
