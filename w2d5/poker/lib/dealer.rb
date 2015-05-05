class Dealer

  attr_accessor :players
  attr_reader :bet_made, :highest_bet, :game

  def initialize(deck)
    @deck, @players = deck, []
    @bet_made = false
    @highest_bet = 0
    @discarded = []
  end

  def join_game(game)
    @game = game
  end

  def collect_cards(cards)
    cards.each { |card| @discarded << card }
  end

  def deal_cards(num = 5)
    @players.each do |player|
      player.hand = Hand.new(@deck.draw(5))
      p player.hand # Remember to remove!
    end
  end

  def add_player(player)
    @players << player
  end

  def take_bet(player, bet_amt)
    raise Exception.new "Must be at least twice previous bet" if bet_amt < 2 * @highest_bet
    game.bets[player] = bet_amt
    game.pot += bet_amt
    @bet_made = true
    @highest_bet = bet_amt
  end

  def pay_winnings(player)
    player.pay_winnings(game.pot)
    @bets = {}
  end

  def bet_made?
    @bet_made
  end

  def call_made(player)
    raise "not enough money" if player.bankroll < highest_bet
    player.pay(@highest_bet)
    game.bets[player] = @highest_bet
  end

  def collect_antes(ante = 1)
    @players.each { |player| player.pay(ante); game.pot += ante }
  end

  def end_round
    @bet_made = false
    game.collect_pot
  end
end
