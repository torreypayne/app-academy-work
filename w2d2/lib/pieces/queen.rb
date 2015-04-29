class Queen < SlidingPiece
  attr_reader :display

  def initialize(board, color, pos, moved=false)
    super
    @display = "\u2655 " if @color == :white
    @display = "\u265B " if @color == :black
  end

  def initial_moves
    updown_moves(@pos) + diagonal_moves(@pos)
  end
end
