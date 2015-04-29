require_relative 'pieces'

class SlidingPiece < Piece  # bishops, queens, rook

  def initialize(board, color, pos)
    super
  end

  def diagonal_moves(pos)
    moves(pos, DIAG_STEPS)
  end

  def updown_moves(pos)
    moves(pos, UPDOWN_STEPS)
  end

  def moves(pos, direction)
    moves = []

    direction.each do |step|
      next_step = [pos[0] + step[0], pos[1] + step[1]]

      until !on_board?(next_step)
        if occupied?(next_step)
          @board[next_step].color != @color ? moves << next_step : break
          break
        end
        moves << next_step
        next_step = [next_step[0] + step[0], next_step[1] + step[1]]
      end
    end

    moves
  end

end
