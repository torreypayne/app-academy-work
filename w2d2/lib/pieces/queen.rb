require_relative 'pieces'
require_relative 'slidingpiece'

class Queen < SlidingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    updown_moves(@pos) + diagonal_moves(@pos)
  end
end
