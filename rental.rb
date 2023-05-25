class Rental
  attr_accessor :date, :book, :person, :person_id

  def initialize(date, book, person)
    @date = date
    @book = book
    book.rentals << self

    @person = person
    person.rentals << self
  end
end