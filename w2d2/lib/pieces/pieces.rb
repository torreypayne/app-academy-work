require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'
require_relative 'queen'
require_relative 'rook'
require_relative 'steppingpiece'
require_relative 'slidingpiece'
require 'byebug'

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
  PAWN_STEPS_BLACK = [[0, 1], [0, 2]]
  PAWN_STEPS_WHITE = [[0, -1], [0, -2]]

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
    # debugger
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
