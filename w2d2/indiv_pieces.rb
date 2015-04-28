class Bishop < SlidingPiece
  include DiagonalMoveable

  def initialize
  end


  def moves
  end
end

class Rook < SlidingPiece
  include UpDownMoveable

  def initialize
  end

  def moves
  end
end

class Queen < SlidingPiece
  include DiagonalMoveable
  include UpDownMoveable

  def initialize
  end

  def moves
  end
end

class King < SteppingPiece
  include UpdownMoveable
  include DiagonalMoveable

  def initialize
  end

  def moves
  end
end

class Knight < SteppingPiece

  def initialize
  end

  def moves
  end
end

class Pawn < Piece

  def initialize
  end

  def moves
  end
end
