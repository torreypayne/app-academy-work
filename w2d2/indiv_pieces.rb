class Bishop < SlidingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    diagonal_moves(@pos)
  end
end

class Rook < SlidingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    updown_moves(@pos)
  end

end

class Queen < SlidingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    updown_moves(@pos) + diagonal_moves(@pos)
  end
end

class King < SteppingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    step_moves(UPDOWN_STEPS)
  end
end

class Knight < SteppingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    step_moves(KNIGHT_STEPS)
  end
end

class Pawn < SteppingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    step_moves(UPDOWN_STEPS)
  end
end
