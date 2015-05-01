require_relative 'checkers_humans'
require_relative 'checkers_board'
require_relative 'piece'

class CheckersGame
  attr_accessor :board

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
    board.render
    until over?
      curr_player = @turn == :white ? @p1 : @p2
      curr_player.play_turn(board, @turn)
      @turn = other_player(@turn)
      board.render
    end

    puts "Game Over. #{curr_player.name} won!"
  end

  def other_player(turn)
    turn == :white ? :red : :white
  end

  def over?
    return true unless pieces.any? { |piece| piece.color == :white }
    return true unless pieces.any? { |piece| piece.color == :red }
  end
end

board = Board.new
torrey = HumanPlayer.new("Torrey")
jon = HumanPlayer.new("Jon")
juego = CheckersGame.new(board, torrey, jon)
juego.play
