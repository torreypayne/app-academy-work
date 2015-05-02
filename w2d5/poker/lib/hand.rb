require_relative 'deck'

class Hand
#     Royal flush <0.01%
# Straight flush (not including royal flush) <0.01%
# Four of a kind 0.02%
# Full house 0.14%
# Flush (excluding royal flush and straight flush) 0.20%
# Straight (excluding royal flush and straight flush) 0.39%
# Three of a kind 2.11%
# Two pair 4.75%
# One pair 42.30%
# No pair / High card 50.10%

  def initialize(deck, hand = nil)
    hand.nil? ? @hand = deck.draw(5) : hand
    @deck = deck
  end

  def cards
    @hand.size
  end

  def values
    values = []
    self.hand.each { |card| values << card.value unless values.include?(card.value) }
    values
  end

  def order_ranks
    self.hand.sort_by { |card| card.value }
  end

  def evaluate

    # if royal_flush
    #   return :royal_flush
    if straight_flush?
      return :straight_flush
    elsif four_kind?
      return :four_of_a_kind
    elsif full_house?
      return :full_house
    elsif flush?
      return :flush
    elsif straight?
      return :straight
    elsif three_kind?
      return :three_of_a_kind
    elsif two_pair?
      return :two_pair
    elsif pair?
      return :one_pair
    else
      return :high_card
    end

  end

  def straight_flush?
    flush? && straight?
  end

  def four_kind?
    hand.each { |card| return true if hand.count(card) == 4 }
    false
  end

  def flush?
    first_card = self.hand.first
    return false if self.hand.any? { |card| card.suit != first_card.suit}
    true
  end

  def full_house?
    three_kind? && values.size == 2
  end

  def straight?
    hand.each_with_index do |card, index|
      next if index == (hand.size - 1)
      return false unless (card.value + 1 == hand[index + 1].value)
    end
    true
  end

  def three_kind?

    hand.each do |card|
      ok_kind = []
      of_kind = hand.select { |other_card| card.value == other_card.value }
      return true if of_kind.size >= 3
    end

    false
  end

  def two_pair?
    values.size == 3 && !three_kind?
  end

  def pair?
    hand.each do |card|
      of_kind = hand.select { |other_card| card.value == other_card.value }
      return true if of_kind.size >=2
    end
    # hand.each { |card| return true if hand.count(card) == 2 }
    false
  end

  # protected

  def hand
    @hand
  end

  def discard(*nums)
    discarded = []
    nums.each { |num| discarded << @hand.delete_at(num) }
    @hand << @deck.draw(discarded.size)
  end
end

deck = Deck.new
hand = Hand.new(deck)
p hand.evaluate
p hand.values
p hand.hand
