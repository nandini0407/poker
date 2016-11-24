class Hand
  HAND_POINTS = {
    high_card: 1,
    one_pair: 2,
    two_pair: 3,
    three_of_a_kind: 4,
    straight: 5,
    flush: 6,
    full_house: 7,
    four_of_a_kind: 8,
    straight_flush: 9
  }

  attr_reader :hand, :hidden, :folded

  def initialize(hand)
    @hand = hand
    @hidden = true
    @folded = false
  end

  def fold
    @folded = true
  end

  def reveal
    @hidden = false
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    card_counts.any? { |_, count| count == 4 }
  end

  def full_house?
    one_pair? && three_of_a_kind?
  end

  def flush?
    suits = []
    @hand.each { |card| suits << card.suit }
    suits.uniq.length == 1
  end

  def straight?
    get_card_values.each_cons(2) do |pair|
      return false unless pair[1] - pair[0] == 1
    end
    true
  end

  def three_of_a_kind?
    card_counts.any? { |_, count| count == 3 }
  end

  def two_pair?
    pairs = 0
    card_counts.each { |_, count| pairs += 1 if count == 2 }
    pairs == 2
  end

  def one_pair?
    card_counts.one? { |_, count| count == 2 }
  end

  def high_card
    get_card_values.max
  end

  def determine_hand
    if self.straight_flush?
      :straight_flush
    elsif self.four_of_a_kind?
      :four_of_a_kind
    elsif self.full_house?
      :full_house
    elsif self.flush?
      :flush
    elsif self.straight?
      :straight
    elsif self.three_of_a_kind?
      :three_of_a_kind
    elsif self.two_pair?
      :two_pair
    elsif self.one_pair?
      :one_pair
    else
      :high_card
    end
  end

  def self.higher_hand(first_hand, second_hand)
    first_hand_kind = first_hand.determine_hand
    second_hand_kind = second_hand.determine_hand

    case HAND_POINTS[first_hand_kind] <=> HAND_POINTS[second_hand_kind]
    when -1
      [second_hand, second_hand_kind]
    when 0
      Hand.determine_tie(first_hand, second_hand)
    when 1
      [first_hand, first_hand_kind]
    end
  end

  def self.determine_tie(first_hand, second_hand)
    case first_hand.determine_hand
    when :straight_flush, :straight, :flush, :high_card
      first_sorted = first_hand.sort_hand
      second_sorted = second_hand.sort_hand
      Hand.get_high_card(first_sorted, second_sorted)
    when :four_of_a_kind, :three_of_a_kind, :full_house
    when :two_pair
    when :one_pair
    end
  end

  def self.get_high_card(first_hand, second_hand)
    i = 4

    until i < 0
      case first_hand.hand[i].value <=> second_hand.hand[i].value
      when -1
        return second_hand
      when 0
        i -= 1
      when 1
        return first_hand
      end
    end

    nil
  end

  def card_counts
    card_counts = Hash.new(0)

    @hand.each do |card|
      card_counts[card.value] += 1
    end

    card_counts
  end

  def get_card_values
    sorted_values = []
    @hand.each do |card|
      sorted_values << card.value
    end
    sorted_values.sort!
  end

  def sort_hand
    @hand.sort_by(&:value)
  end

end
