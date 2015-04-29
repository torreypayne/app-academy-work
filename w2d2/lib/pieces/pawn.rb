require_relative 'pieces'

class Pawn < SteppingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    if @moved == false
      p step_moves(PAWN_STEPS_BLACK)
      puts self.color
      step_moves(PAWN_STEPS_BLACK) if self.color == :black
      step_moves(PAWN_STEPS_WHITE) if self.color == :white

      # if black, increment steps
      # if white, decrement step
    else
      step_moves([PAWN_STEPS_BLACK.first]) if @color == :black
      step_moves([PAWN_STEPS_WHITE.first]) if @color == :white
      # use only first step
    end
  end
end
