require 'byebug'
require_relative 'moveable.rb'

class Piece
  attr_reader :color
  attr_accessor :pos, :moved

  DIAG_STEPS = [[-1,1], [1,1], [-1,-1], [1,-1]]
  UPDOWN_STEPS = [[0,1], [0,-1], [1,0], [-1,0]]
  KNIGHT_STEPS = [[-2, -1],
                  [-2,  1],
                  [-1, -2],
                  [-1,  2],
                  [ 1, -2],
                  [ 1,  2],
                  [ 2, -1],
                  [ 2,  1]]

  def initialize(board, color, pos)
    @board = board
    @color = color
    @pos = pos
    @moved = false
  end

  def moves
    raise "Not yet implemented"
  end

  def valid_moves
    initial_moves.reject { |pos| move_into_check?(pos) }
  end

  def move_into_check?(pos)
    board_dup = @board.deep_dup
    board_dup[pos] = self
    board_dup[@pos] = nil
    # board_dup.fake_move(@pos, pos)
    board_dup.in_check?(@color)
  end

  def occupied?(pos)
    !@board[pos].nil?
  end

  def on_board?(pos)
    pos.none? {|coord| coord < 0 || coord > 7 }
  end

end

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

class SteppingPiece < Piece  # knights and kings?

  def initialize(board, color, pos)
    super
  end

  def step_moves(steps)
    moves = []
    steps.each do |step|
      next_step = [pos[0] + step[0], pos[1] + step[1]]
      moves << next_step if on_board?(next_step) && !occupied?(next_step)
    end

    moves
  end

end

# class Arr
#   include Moveable
#
#   attr_accessor :arr
#
#   def initialize(arr)
#     @arr = arr
#   end
#
#   def diagonal
#     diagonal_moves(@arr)
#   end
#
#   def updown
#     updown_moves(@arr)
#   end
# end

# a = Arr.new([3,3])
# p a.updown
# p a.diagonal
