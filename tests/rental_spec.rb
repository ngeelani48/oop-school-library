require_relative '../rental'

RSpec.describe Rental do
  let(:date) { '2023-05-25' }
  let(:book) { instance_double('Book') }
  let(:person) { instance_double('Person') }

  subject { described_class.new(date, book, person) }

  describe '#initialize' do
    it 'sets the date' do
      expect(subject.date).to eq(date)
    end

    it 'sets the book' do
      expect(subject.book).to eq(book)
    end

    it 'adds the rental to the book' do
      expect(book).to receive(:rentals) << subject
      expect { subject }.to change { book.rentals.count }.by(1)
    end

    it 'sets the person' do
      expect(subject.person).to eq(person)
    end

    it 'adds the rental to the person' do
      expect(person).to receive(:rentals) << subject
      expect { subject }.to change { person.rentals.count }.by(1)
    end
  end
end
