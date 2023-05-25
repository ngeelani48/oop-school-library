require_relative '../rental'
require_relative '../person'

RSpec.describe Rental do
  let(:date) { '2023-05-25' }
  let(:book) { instance_double('Book') }
  let(:person) { Person.new } # Creating an actual instance of Person

  subject { described_class.new(date, book, person) }

  describe '#initialize' do
    it 'sets the date' do
      expect(subject.date).to eq(date)
    end

    it 'sets the book' do
      expect(subject.book).to eq(book)
    end

    it 'adds the rental to the book' do
      expect(book).to receive(:add_rental).with(subject) # Using add_rental method
      subject # Creating the Rental object
    end

    it 'sets the person' do
      expect(subject.person).to eq(person)
    end

    it 'adds the rental to the person' do
      expect(person).to receive(:add_rental).with(subject) # Using add_rental method
      subject # Creating the Rental object
    end
  end
end
