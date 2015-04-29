class Rook < SlidingPiece
  attr_reader :display

  def initialize(board, color, pos, moved=false)
    super
    @display = "\u2656 " if @color == :white
    @display = "\u265C " if @color == :black
  end

  def initial_moves
    updown_moves(@pos)
  end

end
