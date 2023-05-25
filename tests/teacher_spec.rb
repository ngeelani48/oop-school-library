require 'rspec'
require_relative '../teacher'
require_relative '../person'

RSpec.describe Teacher do
  let(:teacher) { described_class.new('Math', 35, 'Jane Smith') }

  describe '#initialize' do
    it 'creates a new teacher with specialization, age, and name' do
      expect(teacher.specialization).to eq('Math')
      expect(teacher.age).to eq(35)
      expect(teacher.name).to eq('Jane Smith')
      expect(teacher.parent_permission).to be(true)
      expect(teacher.rentals).to be_empty
    end
  end

  describe '#can_use_services?' do
    it 'returns true' do
      expect(teacher.can_use_services?).to be(true)
    end
  end
end
