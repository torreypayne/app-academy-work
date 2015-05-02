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

  def initialize(deck)
    @hand = deck.draw(5)
    @deck = deck
  end

  def cards
    @hand.size
  end

  def values
    values = []
    self.each { |card| values << card.value unless values.include?(card.value) }
    values
  end

  def order_ranks
    self.sort_by { |card| card.value }
  end

  def evaluate

    if royal_flush
      return :royal_flush
    elsif straight_flush
      return :straight_flush
    elsif four_kind
      return :four_of_a_kind
    elsif full_house
      return :full_house
    elsif flush
      return :flush
    elsif straight
      return :straight
    elsif three_kind
      return :three_of_a_kind
    elsif two_pair
      return :two_pair
    elsif pair
      return :one_pair
    else
      return :high_card
    end


  def self.flush
    first_card = self.first
    return false if self.any? { |card| card.suit != first_card.suit}
    true
  end

  def self.fullhouse
    three_kind && values.size == 2
  end

  def self.straight
    sorted_hand = self.order_ranks
    sorted_hand.each_with_index do |card, index|
      next if index == (sorted_hand.size - 1)
      return false unless (card.value + 1 == sorted_hand[index + 1].value)
    end
    true
  end

  def three_kind
    self.each do |card|
      return true is self.count(card) == 3
    end

    false
  end

  def two_pair
    tracker = 0
    sorted_hand = self.order_ranks
    sorted_hand.reverse.each do |card|
      tracker += 1 if sorted_hand.count(card) == 2
    end
    return true if tracker == 4
    false
  end

  def self.pair
    sorted_hand = self.order_ranks
    sorted_hand.each { |card| return true if self.count(card) == 2 }
    false
  end

  protected

  def hand
    @hand
  end

  def discard(*nums)
    discarded = []
    nums.each { |num| discarded << @hand.delete_at(num) }
    @hand << @deck.draw(discarded.size)
  end
end
