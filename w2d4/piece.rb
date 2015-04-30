require_relative 'checkers_board'
require 'byebug'

class Piece
  attr_accessor :board, :pos
  attr_reader :color


  DIAG_STEPS_DOWN = [[1,-1], [1,1]]
  DIAG_STEPS_UP = [[-1,-1], [-1,1]]

  def initialize(board, color, pos)
    @board  = board
    @color = color
    @pos = pos
    @king = false
  end

  def make_king
    @king = true
  end

  def king?
    @king
  end

  def ours?(color)
    self.color == color
  end

  def simple_moves
    moves = []
    direction = color == :white ? DIAG_STEPS_DOWN : DIAG_STEPS_UP
    direction.each do |next_step|
      next_move = [pos.first + next_step.first, pos.last + next_step.last]
      moves << next_move if @board.on_board?(next_move)
    end

    moves
  end

  def perform_slide(x,y)
    debugger
    raise "Not valid move!" if !simple_moves.include?([x,y])
    coord = [x,y]
    old_pos = @pos
    @pos = coord
    board[[x,y]] = self
    p board[coord]
    board[old_pos] = nil
  end

  def perform_jump(x,y)

  end
end

board = Board.new
board.set_board
board.render
board[[2,1]].perform_slide(3,2)
board.render
