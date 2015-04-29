module Moveable

  DIAG_STEPS = [[-1,1], [1,1], [-1,-1], [1,-1]]
  UP_DOWN_STEPS = [[0,1], [0,-1], [1,0], [-1,0]]

  def diagonal_moves(pos)
    moves(pos, DIAG_STEPS)
  end

  def updown_moves(pos)
    moves(pos, UP_DOWN_STEPS)
  end

  def moves(pos, direction)
    moves = []

    direction.each do |step|
      next_step = [pos[0] + step[0], pos[1] + step[1]]

      until on_board?(next_step) == false

        moves << next_step
        next_step = [next_step[0] + step[0], next_step[1] + step[1]]
      end
    end

    moves
  end

  def on_board?(pos)
    pos.none? {|c| c < 0 || c > 7 }
  end
end
