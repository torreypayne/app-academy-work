require 'byebug'
require_relative 'moveable.rb'

class Piece
  include Moveable

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

end

class SteppingPiece < Piece  # knights, kings, pawns?

  def initialize(board, color, pos)
    super
  end

end


class Arr
  include Moveable

  attr_accessor :arr

  def initialize(arr)
    @arr = arr
  end

  def diagonal
    diagonal_moves(@arr)
  end

  def updown
    updown_moves(@arr)
  end
end

a = Arr.new([3,3])
p a.updown
p a.diagonal
