class Card
  attr_reader :suit, :value, :rank

  RANKS = {
    2 => :deuce,
    3 => :three,
    4 => :four,
    5 => :five,
    6 => :six,
    7 => :seven,
    8 => :eight,
    9 => :nine,
    10 => :ten,
    11 => :jack,
    12 => :queen,
    13 => :king,
    14 => :ace
  }

  SUITS = [:clubs, :spades, :hearts, :diamonds]

  def self.suits
    SUITS
  end

  def self.ranks
    RANKS
  end

  def initialize(suit, value)
    @suit = suit
    @value = value
    @rank = RANKS[value]
  end

end
