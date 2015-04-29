require_relative 'piece'
require_relative 'slideable'

class Bishop < SlidingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    diagonal_moves(@pos)
  end
end
