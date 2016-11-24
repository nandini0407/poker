require 'card'
require 'rspec'

describe Card do
  subject(:my_card) { Card.new(:h, 10) }
  describe '#initialize' do
    it 'should raise error if given invalid suit or value' do
      expect{ Card.new(:a, 10) }.to raise_error(ArgumentError)
      expect{ Card.new(:h, 13) }.to raise_error(ArgumentError)
    end

    it 'assigns a value and a suit' do
      expect(my_card.value).to eq(10)
      expect(my_card.suit).to eq(:h)
    end
  end
end
