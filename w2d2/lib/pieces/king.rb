require_relative 'pieces'
require_relative 'steppingpiece'

class King < SteppingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    step_moves(UPDOWN_STEPS)
  end
end
