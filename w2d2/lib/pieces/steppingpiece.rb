class SteppingPiece < Piece  # knights and kings?

  def initialize(board, color, pos, moved=false)
    super
  end

  def step_moves(steps)
    moves = []
    steps.each do |step|
      # p step
      next_step = [pos[0] + step[0], pos[1] + step[1]]
      moves << next_step if on_board?(next_step) && !occupied?(next_step)
    end

    moves
  end

end
