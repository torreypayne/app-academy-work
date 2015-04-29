class Pawn < Piece
  PAWN_STEPS_BLACK = [[1, 0], [2, 0]]
  PAWN_STEPS_WHITE = [[-1, 0], [-2, 0]]

  def display
    return "\u2659 " if @color == :white
    return "\u265F " if @color == :black
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
