require 'deck'
require 'rspec'

describe Deck do
  subject(:my_deck) { Deck.new }

  describe '#initialize' do
    it 'should create a 52 card deck' do
      expect(my_deck.deck.length).to eq(52)
    end

    it 'should create a deck of card objects' do
      expect(my_deck.deck.all? { |card| card.is_a?(Card) }).to be_truthy
    end

    it 'should return an array of unique cards' do
      expect(my_deck.deck.uniq.length).to eq(52)
    end
  end

  describe '#shuffle!' do
    it 'should shuffle the deck' do
      deck_before = my_deck.deck.dup
      my_deck.shuffle!
      expect(deck_before).to_not eq(my_deck.deck)
    end

    it 'should mutate the original deck array' do
      deck_before = my_deck.deck
      my_deck.shuffle!
      expect(deck_before).to eq(my_deck.deck)
    end
  end

  describe '#deal' do
    it 'should deal 5 cards' do
      hand = my_deck.deal
      expect(hand.hand.length).to eq(5)
    end

    it 'should mutate the original deck' do
      hand = my_deck.deal
      expect(my_deck.deck.length).to eq(47)
      expect(hand.hand.none? { |card| my_deck.deck.include?(card) }).to be_truthy
    end
  end

  describe '#hit' do
    it 'should deal (return) the top most card' do
      last_card = my_deck.deck.last
      expect(my_deck.hit).to eq(last_card)
    end

    it 'should mutate the original deck' do
      hit = my_deck.hit
      expect(my_deck.deck.length).to eq(51)
      expect(!my_deck.deck.include?(hit)).to be_truthy
    end
  end

end
