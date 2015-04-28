class Bishop < SlidingPiece
  include Moveable

  def initialize
  end


  def moves
  end
end

class Rook < SlidingPiece
  include Moveable

  def initialize
  end

  def moves
  end
end

class Queen < SlidingPiece
  include Moveable

  def initialize
  end

  def moves
  end
end

class King < SteppingPiece
  include Moveable

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
