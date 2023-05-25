require 'rspec'
require_relative '../person'
require_relative '../rental'
require_relative '../book'

RSpec.describe Person do
  let(:person) { described_class.new(31, 'Nafees') }

  describe '#initialize' do
    it 'creates a new person with age, name, and parent permission' do
      expect(person.age).to eq(31)
      expect(person.name).to eq('Nafees')
      expect(person.parent_permission).to be(true)
      expect(person.rentals).to be_empty
    end
  end

  describe '#can_use_services?' do
    context 'when the person is of age' do
      it 'returns true' do
        expect(person.can_use_services?).to be(true)
      end
    end

    context 'when the person is underage but has parent permission' do
      let(:person) { described_class.new(15, 'John', parent_permission: true) }

      it 'returns true' do
        expect(person.can_use_services?).to be(true)
      end
    end

    context 'when the person is underage and does not have parent permission' do
      let(:person) { described_class.new(14, 'olive', parent_permission: false) }

      it 'returns false' do
        expect(person.can_use_services?).to be(false)
      end
    end
  end

  describe '#correct_name' do
    it 'returns the correct name' do
      expect(person.correct_name).to eq('Nafees')
    end
  end

  describe '#add_rental' do
    let(:book) { Book.new('Book Title', 'Book Author') }
    let(:date) { '2023-05-23' }

    it 'creates a new rental with the person, book, and date' do
      rental = person.add_rental(date, book)
      expect(rental).to be_a(Rental)
      expect(rental.person).to eq(person)
      expect(rental.book).to eq(book)
      expect(rental.date).to eq(date)
      expect(person.rentals).to include(rental)
    end
  end
end
