class Pawn < Piece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    if @moved == false
      # puts self.color
      return pawn_moves(PAWN_STEPS_BLACK) if @color == :black
      return pawn_moves(PAWN_STEPS_WHITE) if @color == :white
    else
      return pawn_moves([PAWN_STEPS_BLACK.first]) if @color == :black
      return pawn_moves([PAWN_STEPS_WHITE.first]) if @color == :white
    end
  end

  def pawn_moves(steps)
    moves = []
    # p steps
    steps.each do |step|

      next_step = [pos[0] + step[0], pos[1] + step[1]]
      # p self.color
      # print "next step "
      # p next_step
      # print "on board? "
      # p on_board?(next_step)
      # print "occupied? "
      # p occupied?(next_step)
      moves << next_step if on_board?(next_step) && !occupied?(next_step)
    end

    moves
  end

end
