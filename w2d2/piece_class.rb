class Piece

  def initialize(board, color, pos)
    @board = board
    @color = color
    @pos = pos
    @moved = false
  end

  def moves
    raise "Not yet implemented"
  end

end

class SlidingPiece < Piece  # bishops, queens, rook

  def initialize(board, color, pos)
    super
  end

end

class SteppingPiece < Piece  # knights, kings, pawns?

  def initialize(board, color, pos)
    super
  end

end

module DiagonalMoveable

  DIAG_STEPS = [ [-1,1], [1,1], [-1,-1], [1,-1]]

  def diagonal_moves(pos)
    

    # Finish
  end

  def on_board?(pos)
    pos.none? {|c| c < 0 && c > 7 }
  end
end

module UpDownMoveable # rename

  DELTAS = [ [0,1], [0,-1], [1,0], [-1,0]]

  def updown_moves(pos)
    #Finish
  end

end
