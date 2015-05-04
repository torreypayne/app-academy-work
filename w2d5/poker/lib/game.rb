require_relative 'dealer'
require_relative 'hand'
require_relative 'player'
require_relative 'card'
require_relative 'deck'

class Game

  RANKS = {
    :high_card => 1,
    :one_pair => 2,
    :two_pair => 3,
    :three_of_a_kind => 4,
    :straight => 5,
    :flush => 6,
    :full_house => 7,
    :four_of_a_kind => 8,
    :straight_flush => 9
  }

  attr_accessor :bets, :dealer, :pot, :remaining

  def initialize(dealer)
    @dealer = dealer
    @pot = 0
    players.each do |player|
      player.hand = Hand.new(@deck.draw(5))
    end
    @bets = {}
    @remaining = []
    @dealer.join_game(self)
    big_blind = players.first
  end

  def play_round
    dealer.deal_cards
    # Collect antes
    dealer.collect_antes
    # Begin betting
    players.each { |player| player.play_turn } # Bet or fold
    collect_pot
    # If more than one player remains, "draw" phase begins.
    if remaining.size > 1

      remaining.each do |player|
        discards = player.discard_cards
        player.draw(discards)
        player.play_turn
      end
      collect_pot
      if remaining.size > 1
        winner = reveal_hands
        dealer.pay_winnings(winner)
        dealer.end_round
        remaining = []
      else
        dealer.pay_winnings(remaining.pop)
        dealer.end_round
        remaining = []
      end
    elsif remaining.size == 1
      dealer.pay_winnings(@bets.keys.pop)
    else
      dealer.pay_winnings(big_blind)
    end
  end

  def players
    @dealer.players
  end

  def collect_pot
    @bets.keys.each do |player|
      @pot += @bets[player]
      p player
      remaining << player
    end
    @bets = {}
  end

  def reveal_hands
    results = {}
    @bets.keys.each { |player| results[player] = player.hand.evaluate }
    best_hand(results)
  end

  def best_hand(results)
    highest = 0
    winner = []
    results.each do |player, value|
      if RANK[value] > highest
        highest = RANK[value]
        winner = [player]
      elsif RANK[value] == highest
        winner << player
      end
    end

    winner
  end
end

my_deck = Deck.new
my_dealer = Dealer.new(my_deck)
my_game = Game.new(my_dealer)
torrey = Player.new(my_dealer, "Torrey", 100)
jack = Player.new(my_dealer, "Jack", 100)
my_game.play_round
