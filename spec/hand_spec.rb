require 'hand'
require 'rspec'

describe Hand do
  let(:cards) { [[:h, 10], [:s, 11], [:c, 2], [:d, 5], [:d, 12]] }
  subject(:my_hand) { Hand.new(cards) }
  describe '#initialize' do
    it 'should assign the array of cards to its instance variable' do
      expect(my_hand.hand).to be_a(Array)
    end

    it 'should set @hidden to true' do
      expect(my_hand.hidden).to eq(true)
    end

    it 'should set @folded to false' do
      expect(my_hand.folded).to eq(false)
    end

    it 'should have a hand of length 5' do
      expect(my_hand.hand.length).to eq(5)
    end
  end

  describe '#reveal' do
    it 'should set @hidden to false' do
      my_hand.reveal
      expect(my_hand.hidden).to eq(false)
    end
  end

  describe '#fold' do
    it 'should set @folded to true' do
      my_hand.fold
      expect(my_hand.folded).to eq(true)
    end
  end

  describe '#straight_flush?' do
    let(:cards) { [[:h, 10], [:h, 11], [:h, 8], [:h, 9], [:h, 12]] }
    subject(:my_hand) { Hand.new(cards) }
    it 'returns true if hand has sequential cards of the same suit' do
      cards.each { |card| allow(card).to receive(:suit).and_return(:h) }
      cards.each { |card| allow(card).to receive(:value).and_return(card.last) }
      expect(my_hand.straight_flush?).to be_truthy
    end
  end

  describe '#four_of_a_kind?' do
    let(:cards) { [[:h, 10], [:d, 10], [:c, 10], [:s, 10], [:h, 12]] }
    subject(:my_hand) { Hand.new(cards) }
    it 'returns true if hand has four cards of same value' do
      cards.each { |card| allow(card).to receive(:value).and_return(card.last) }
      expect(my_hand.four_of_a_kind?).to be_truthy
    end
  end

  describe '#full_house?' do
    let(:cards) { [[:h, 10], [:d, 10], [:c, 10], [:s, 12], [:h, 12]] }
    subject(:my_hand) { Hand.new(cards) }
    it 'returns true if hand three cards of one value and two cards of another value' do
      cards.each { |card| allow(card).to receive(:value).and_return(card.last) }
      expect(my_hand.full_house?).to be_truthy
    end
  end

  describe '#flush?' do
    let(:cards) { [[:h, 10], [:h, 7], [:h, 5], [:h, 2], [:h, 12]] }
    subject(:my_hand) { Hand.new(cards) }
    it 'returns true if entire hand has some suit' do
      cards.each { |card| allow(card).to receive(:suit).and_return(card.first) }
      expect(my_hand.flush?).to be_truthy
    end
  end

  describe '#straight?' do
    let(:cards) { [[:h, 10], [:d, 9], [:c, 8], [:s, 11], [:h, 12]] }
    subject(:my_hand) { Hand.new(cards) }
    it 'returns true if hand has cards of sequential values of any suit' do
      cards.each { |card| allow(card).to receive(:value).and_return(card.last) }
      expect(my_hand.straight?).to be_truthy
    end
  end

  describe '#three_of_a_kind?' do
    let(:cards) { [[:h, 10], [:d, 10], [:c, 10], [:s, 7], [:h, 12]] }
    subject(:my_hand) { Hand.new(cards) }
    it 'returns true if hand has three cards of same value' do
      cards.each { |card| allow(card).to receive(:value).and_return(card.last) }
      expect(my_hand.three_of_a_kind?).to be_truthy
    end
  end

  describe '#two_pair?' do
    let(:cards) { [[:h, 10], [:d, 10], [:c, 5], [:s, 5], [:h, 12]] }
    subject(:my_hand) { Hand.new(cards) }
    it 'returns true if hand has two pairs of cards of same value' do
      cards.each { |card| allow(card).to receive(:value).and_return(card.last) }
      expect(my_hand.two_pair?).to be_truthy
    end
  end

  describe '#one_pair?' do
    let(:cards) { [[:h, 10], [:d, 10], [:c, 5], [:s, 2], [:h, 12]] }
    subject(:my_hand) { Hand.new(cards) }
    it 'returns true if hand has one pair of cards of same value' do
      cards.each { |card| allow(card).to receive(:value).and_return(card.last) }
      expect(my_hand.one_pair?).to be_truthy
    end
  end

  describe '#high_card' do
    let(:cards) { [[:h, 10], [:d, 10], [:c, 5], [:s, 2], [:h, 12]] }
    subject(:my_hand) { Hand.new(cards) }
    it 'returns value of card of highest value' do
      cards.each { |card| allow(card).to receive(:value).and_return(card.last) }
      expect(my_hand.high_card).to eq(12)
    end
  end

  describe '#sort_hand' do
    let(:cards) { [[:h, 10], [:d, 10], [:c, 5], [:s, 2], [:h, 12]] }
    subject(:my_hand) { Hand.new(cards) }
    it 'sorts the hand of cards by value' do
      cards.each { |card| allow(card).to receive(:value).and_return(card.last) }
      expect(my_hand.sort_hand).to eq([[:s, 2], [:c, 5], [:h, 10], [:d, 10], [:h, 12]])
    end
  end

  describe '#determine_hand' do
    let(:straight_flush) { [[:h, 10], [:h, 11], [:h, 8], [:h, 9], [:h, 12]] }
    let(:my_hand1) { Hand.new(straight_flush) }
    let(:full_house) { [[:h, 10], [:d, 10], [:c, 10], [:s, 12], [:h, 12]] }
    let(:my_hand2) { Hand.new(full_house) }
    let(:flush) { [[:h, 10], [:h, 7], [:h, 5], [:h, 2], [:h, 12]] }
    subject(:my_hand3) { Hand.new(flush) }

    it 'returns the best hand category of that hand' do
      straight_flush.each { |card| allow(card).to receive(:value).and_return(card.last) }
      straight_flush.each { |card| allow(card).to receive(:suit).and_return(:h) }
      full_house.each { |card| allow(card).to receive(:value).and_return(card.last) }
      flush.each { |card| allow(card).to receive(:suit).and_return(:h) }
      expect(my_hand1.determine_hand).to eq(:straight_flush)
      expect(my_hand2.determine_hand).to eq(:full_house)
      expect(my_hand3.determine_hand).to eq(:flush)
    end
  end

  describe '#strongest_hand' do
    it 'accepts an array of hands'
    it 'returns the strongest_hand'
  end

  describe '::get_high_card' do
    context 'when there is no tie' do
      let(:cards1) { [[:h, 2], [:d, 5], [:c, 10], [:s, 10], [:h, 11]] }
      let(:cards2) { [[:h, 2], [:d, 4], [:c, 7], [:s, 9], [:h, 12]] }
      let(:my_hand1) { Hand.new(cards1) }
      let(:my_hand2) { Hand.new(cards2) }
      it 'returns the hand that has the highest card' do
        cards1.each { |card| allow(card).to receive(:value).and_return(card.last) }
        cards2.each { |card| allow(card).to receive(:value).and_return(card.last) }
        expect(Hand.get_high_card(my_hand1, my_hand2)).to eq(my_hand2)
      end
    end

    context 'when there is at least one tie' do
      let(:cards1) { [[:h, 2], [:d, 5], [:c, 10], [:s, 9], [:h, 11]] }
      let(:cards2) { [[:h, 2], [:d, 4], [:c, 7], [:s, 9], [:h, 11]] }
      let(:my_hand1) { Hand.new(cards1) }
      let(:my_hand2) { Hand.new(cards2) }
      it 'checks next highest card values if there is a tie' do
        cards1.each { |card| allow(card).to receive(:value).and_return(card.last) }
        cards2.each { |card| allow(card).to receive(:value).and_return(card.last) }
        expect(Hand.get_high_card(my_hand1, my_hand2)).to eq(my_hand1)
      end
    end

    context 'when there is a full tie' do
      let(:cards1) { [[:h, 2], [:d, 4], [:c, 7], [:s, 9], [:h, 11]] }
      let(:cards2) { [[:h, 2], [:d, 4], [:c, 7], [:s, 9], [:h, 11]] }
      let(:my_hand1) { Hand.new(cards1) }
      let(:my_hand2) { Hand.new(cards2) }
      it 'returns nil if all cards in both hands have equal values' do
        cards1.each { |card| allow(card).to receive(:value).and_return(card.last) }
        cards2.each { |card| allow(card).to receive(:value).and_return(card.last) }
        expect(Hand.get_high_card(my_hand1, my_hand2)).to eq(nil)
      end
    end
  end

  describe '::get_high_set' do
    let(:cards1) { [[:h, 2], [:d, 2], [:c, 2], [:s, 2], [:h, 11]] }
    let(:cards2) { [[:h, 4], [:d, 4], [:c, 4], [:s, 4], [:h, 12]] }
    let(:my_hand1) { Hand.new(cards1) }
    let(:my_hand2) { Hand.new(cards2) }
    it 'returns the hand that has the highest set of cards' do
      cards1.each { |card| allow(card).to receive(:value).and_return(card.last) }
      cards2.each { |card| allow(card).to receive(:value).and_return(card.last) }
      expect(Hand.get_high_set(my_hand1, my_hand2)).to eq(my_hand2)
    end
  end

end
