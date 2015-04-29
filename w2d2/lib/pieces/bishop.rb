class Bishop < SlidingPiece
  attr_reader :display

  def initialize(board, color, pos, moved=false)
    super
    @display = "\u2657 " if @color == :white
    @display = "\u265D " if @color == :black
  end

  def initial_moves
    diagonal_moves(@pos)
  end
end
