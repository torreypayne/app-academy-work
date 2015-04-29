class King < SteppingPiece
  attr_reader :display

  def initialize(board, color, pos, moved=false)
    super
    @display = "\u2654 " if @color == :white
    @display = "\u265A " if @color == :black
  end

  def initial_moves
    step_moves(UPDOWN_STEPS)
  end
end
