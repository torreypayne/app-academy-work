require_relative 'checkers_board'
require 'byebug'

class Piece
  attr_accessor :board, :pos
  attr_reader :color


  DIAG_STEPS_DOWN = [[1,-1], [1,1]]
  DIAG_JUMPS_DOWN = [[2,-2], [2,2]]
  # DIAG_JUMPS_DOWN = DIAG_STEPS_DOWN.map {|step| step.map { |el| el * 2 } }
  DIAG_STEPS_UP = [[-1,-1], [-1,1]]
  DIAG_JUMPS_UP = [[-2,-2], [-2,2]]

  def initialize(board, color, pos)
    @board  = board
    @color = color
    @pos = pos
    @king = false
  end

  def make_king
    @king = true
  end

  def king?
    @king
  end

  def ours?(color)
    self.color == color
  end

  def simple_moves
    moves = []
    direction = color == :white ? DIAG_STEPS_DOWN : DIAG_STEPS_UP
    direction.each do |next_step|
      next_move = [pos.first + next_step.first, pos.last + next_step.last]
      moves << next_move if @board.on_board?(next_move)
    end

    moves
  end

  def simple_jumps
    # debugger
    jumps = []
    direction = color == :white ? DIAG_JUMPS_DOWN : DIAG_JUMPS_UP
    direction.each do |jump|
      x, y = jump
      jump = [pos.first + x, pos.last + y]
      middle_tile = board[[pos.first + x.div(2), pos.last + y.div(2)]]
      next if middle_tile.nil?
      jumps << jump if board.on_board?(jump) && middle_tile.between_tile?(color)
    end

    jumps
  end

  def between_tile?(color)
    !self.nil? && self.color != color
  end

  def perform_slide(x,y)
    # debugger
    raise "Not valid move!" if !simple_moves.include?([x,y])
    coord = [x,y]
    old_pos = @pos
    @pos = coord
    board[coord] = self
    board[old_pos] = nil
  end

  def perform_jump(dx,dy)
    raise "Not valid move!" if !simple_jumps.include?([dx,dy])
    coord = [dx,dy]
    old_pos = @pos # This makes calculating mid-point cleaner
    x, y = old_pos
    @pos = coord
    board[coord] = self
    board[old_pos] = nil
    mid_point = [(x + dx)/2, (y + dy)/2]
    board[mid_point] = nil
  end
end

board = Board.new
board.set_board
board.render
board[[2,1]].perform_slide(3,2)
board[[3,2]].perform_slide(4,3)
board.render
board[[5,2]].perform_jump(3,4)
board.render
