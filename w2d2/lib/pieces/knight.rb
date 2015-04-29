class Knight < SteppingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    step_moves(KNIGHT_STEPS)
  end
end
