require 'rspec'
require_relative '../book'

RSpec.describe Book do
  let(:title) { 'Alice in the Wonderland' }
  let(:author) { 'Lewis Carroll' }
  subject(:book) { described_class.new(title, author) }

  describe '#initialize' do
    it 'creates a new book with title and author' do
      expect(book.title).to eq(title)
      expect(book.author).to eq(author)
      expect(book.rentals).to be_empty
    end
  end

  describe '#add_rental' do
    let(:rental) { double('Rental') }

    context 'when the rental is not already added' do
      it 'adds the rental to the book' do
        expect(rental).to receive(:book=).with(book)
        book.add_rental(rental)
        expect(book.rentals).to include(rental)
      end
    end

    context 'when the rental is already added' do
      it 'does not add the rental again' do
        expect(rental).not_to receive(:book=).with(book)
        book.rentals << rental
        book.add_rental(rental)
        expect(book.rentals).to include(rental)
      end
    end
  end

  describe '#to_json' do
    it 'returns the book details as JSON' do
      expected_json = {
        'title' => book.title,
        'author' => book.author
      }.to_json
      expect(book.to_json).to eq(expected_json)
    end
  end
end
