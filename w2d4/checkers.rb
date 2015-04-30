require_relative 'checkers_humans'
require_relative 'checkers_board'
require_relative 'piece'

class CheckersGame
  attr_accesor :board

  def initialize(board, player1, player2)
    @p1 = player1
    @p2 = player2
    colors = [:red, :white]
    @turn = :white
    @board = board
    @board.set_board
  end

  def white_player
    @p1
  end

  def red_player
    @p2
  end

  def pieces
    board.grid.flatten.compact
  end

  def play
    until over?
      curr_player = @turn == :white ? @p1 : @p2
      curr_player.play_turn
      @turn = other_player(@turn)
    end

    puts "Game Over. #{curr_player.name} won!"
  end

  def other_player(turn)
    turn == :white ? :red : :white
  end

  def over?
    return true unless pieces.any? { |pieces| piece.color == :white }
    return true unless pieces.any? { |pieces| piece.color == :red }
  end
end

board = CheckersBoard.new
torrey = HumanPlayer.new(board, "Torrey")
jon = HumanPlayer.new(board, "Jon")
juego = CheckersGame.new(board, torrey, jon)
juego.pieces
