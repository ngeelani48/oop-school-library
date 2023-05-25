class Rental
  attr_accessor :date, :book, :person, :person_id

  def initialize(date, book, person)
    @date = date
    @book = book
    book.add_rental(self)

    @person = person
    person.add_rental(self)
  end
end
