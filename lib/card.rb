class Card
  attr_reader :suit, :value

  SUITS = [:h, :s, :c, :d]

  VALUES = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]

  def initialize(suit, value)
    raise ArgumentError unless SUITS.include?(suit) && VALUES.include?(value)
    @suit = suit
    @value = value
  end

end
