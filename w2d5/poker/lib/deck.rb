require_relative 'card'

class Deck

  def initialize
    @cards = Deck.make_deck
  end

  def self.make_deck
    cards = []
    (2..14).to_a.each do |rank|
      Card.suits.each { |suit| cards << Card.new(suit, rank) }
    end

    cards.shuffle
  end

  # def shuffle
  #   @cards.shuffle
  # end

  def draw(num = 1)
    @cards.pop(num)
  end

  def count
    @cards.size
  end

  def suit_counts
    suits = []
    @cards.each{ |card| suits << card.suit if !suits.include?(card.suit) }

    suits.size
  end
end
