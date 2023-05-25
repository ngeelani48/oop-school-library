require_relative '../capitalize_decorator'
require_relative '../nameable'

RSpec.describe CapitalizeDecorator do
  let(:nameable) { Nameable.new }

  describe '#correct_name' do
    it 'returns the capitalized correct name' do
      allow(nameable).to receive(:correct_name).and_return('john doe')
      decorator = CapitalizeDecorator.new(nameable: nameable)
      expect(decorator.correct_name).to eq('John doe')
    end
  end
end
