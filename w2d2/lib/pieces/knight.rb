class Knight < SteppingPiece
  attr_reader :display

  def initialize(board, color, pos, moved=false)
    super
    @display = "\u2658 " if @color == :white
    @display = "\u265E " if @color == :black
  end

  def initial_moves
    step_moves(KNIGHT_STEPS)
  end
end
