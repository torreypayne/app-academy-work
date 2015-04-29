require_relative 'board'

class Game
  attr_accessor :board

  def initialize
    @board = ChessBoard.new
  end

  def play
    # player1 = HumanPlayer.new(color)
    # player2 = HumanPlayer.new(color)
    # curr_player = player1

    # until over?
      # coords = prompt_and_parse  => retry if coord[0] not your piece
      # curr_player.play_turn(coord[0], coord[1])
      # switch turn
      # curr_player == player1 ? curr_player = player2 : curr_player = player1

    # end
  end

  def over?
    @board.checkmate?(:black) || @board.checkmate?(:white)
  end

  def prompt_and_parse
    letter_coords = { "a" => 0,
                      "b" => 1,
                      "c" => 2,
                      "d" => 3,
                      "e" => 4,
                      "f" => 5,
                      "g" => 6,
                      "h" => 7 }

    puts "Where do you want to move? (i.e. f2,f3)"
    coords = gets.chomp.split(",")
    new_coords = coords.map do |coord|
      letter = coord[0]
      number = coord[1].to_i
      [number - 1, letter_coords[letter]]
    end

    new_coords
  end
end

class HumanPlayer
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn(move_from, move_to)
    @board.move(move_from, move_to)
    # Handle errors

  end

end


game = Game.new
game.prompt_and_parse
