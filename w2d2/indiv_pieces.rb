# require_relative 'piece_class.rb'
# require_relative 'chess_board_class.rb'

class Bishop < SlidingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    diagonal_moves(@pos)
  end
end

class Rook < SlidingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    updown_moves(@pos)
  end

end

class Queen < SlidingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    updown_moves(@pos) + diagonal_moves(@pos)
  end
end

class King < SteppingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    step_moves(UPDOWN_STEPS)
  end
end

class Knight < SteppingPiece

  def initialize(board, color, pos)
    super
  end

  def initial_moves
    step_moves(KNIGHT_STEPS)
  end
end

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
