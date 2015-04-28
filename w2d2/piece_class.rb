require 'byebug'
require_relative 'moveable.rb'

class Piece
  attr_reader :color, :pos

  DIAG_STEPS = [[-1,1], [1,1], [-1,-1], [1,-1]]
  UP_DOWN_STEPS = [[0,1], [0,-1], [1,0], [-1,0]]
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

end

class SlidingPiece < Piece  # bishops, queens, rook

  def initialize(board, color, pos)
    super
  end

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

      until on_board?(next_step) == false #|| occupied?(next_step) by same color

        moves << next_step
        next_step = [next_step[0] + step[0], next_step[1] + step[1]]
      end
    end

    moves
  end

  def occupied?(pos)
    #check pos on board, return true if nil
  end

  def on_board?(pos)
    pos.none? {|c| c < 0 || c > 7 }
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
      moves << next_step if on_board?(next_step) || !occupied?(next_step)
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
