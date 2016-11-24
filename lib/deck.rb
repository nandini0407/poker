require_relative 'card'
require_relative 'hand'

class Deck

  attr_reader :deck

  SUITS = [:h, :s, :c, :d]

  VALUES = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]

  def self.make_deck
    deck_arr = []
    SUITS.each do |suit|
      VALUES.each do |value|
        deck_arr << Card.new(suit, value)
      end
    end
    deck_arr
  end

  def initialize
    @deck = Deck.make_deck
  end

  def shuffle!
    @deck.shuffle!
  end

  def deal
    hand = []
    5.times do
      hand << @deck.pop
    end
    Hand.new(hand)
  end

  def hit
    @deck.pop
  end

end
