require 'rspec'
require_relative '../rental'
require_relative '../book'
require_relative '../person'

RSpec.describe Rental do
  let(:book) { Book.new('The Lord of the Rings', 'J.R.R. Tolkien') }
  let(:person) { Person.new(25, 'John Doe') }
  let(:rental_date) { '2023-05-23' }
  let(:rental) { described_class.new(rental_date, book, person) }

  describe '#initialize' do
    it 'creates a new rental with the specified date, book, and person' do
      expect(rental.date).to eq(rental_date)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
      expect(book.rentals).to include(rental)
      expect(person.rentals).to include(rental)
    end
  end
end
