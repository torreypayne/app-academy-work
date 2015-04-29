require_relative 'pieces'
require_relative 'slidingpiece'

class Bishop < SlidingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    diagonal_moves(@pos)
  end
end
