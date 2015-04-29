class Pawn < Piece
  attr_reader :display

  def initialize(board, color, pos, moved=false)
    super
    @display = "\u2659 " if @color == :white
    @display = "\u265F " if @color == :black
  end

  def initial_moves
    if @moved == false
      return pawn_moves(PAWN_STEPS_BLACK) if @color == :black
      return pawn_moves(PAWN_STEPS_WHITE) if @color == :white
    else
      return pawn_moves([PAWN_STEPS_BLACK.first]) if @color == :black
      return pawn_moves([PAWN_STEPS_WHITE.first]) if @color == :white
    end
  end

  def pawn_moves(steps)
    moves = []
    steps.each do |step|
      next_step = [pos[0] + step[0], pos[1] + step[1]]
      moves << next_step if on_board?(next_step) && !occupied?(next_step)
    end

    moves
  end

end
