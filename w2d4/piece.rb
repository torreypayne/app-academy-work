require_relative 'checkers_board'
require 'byebug'

class InvalidMoveError < StandardError; end

class Piece
  attr_accessor :board, :pos, :king
  attr_reader :color


  DIAG_STEPS_DOWN = [[1,-1], [1,1]]
  DIAG_JUMPS_DOWN = [[2,-2], [2,2]]
  # DIAG_JUMPS_DOWN = DIAG_STEPS_DOWN.map {|step| step.map { |el| el * 2 } }
  DIAG_STEPS_UP = [[-1,-1], [-1,1]]
  DIAG_JUMPS_UP = [[-2,-2], [-2,2]]

  def initialize(board, color, pos, king = false)
    @board  = board
    @color = color
    @pos = pos
    @king = king
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
      moves << next_move if @board.on_board?(next_move) && @board[next_move].nil?# check for occupation
    end

    moves
  end

  def simple_jumps
    jumps = []
    direction = color == :white ? DIAG_JUMPS_DOWN : DIAG_JUMPS_UP
    direction.each do |jump|
      x, y = jump
      jump = [pos.first + x, pos.last + y]
      # Check if jump is empty
      middle_tile = board[[pos.first + x.div(2), pos.last + y.div(2)]]
      p "gets here"
      next if (middle_tile.nil? || !board[jump].nil?)
      next unless board.on_board?(jump) && middle_tile.between_tile?(color)
      jumps << jump
      # Dup the board, check for for additional valid jumps.
    end

    jumps
  end

  def between_tile?(color)
    self.color != color
  end

  def perform_slide(dx,dy)
    coord = [dx,dy]
    raise InvalidMoveError.new "Not valid move!" unless simple_moves.include?(coord)
    old_pos = @pos
    @pos = coord
    board[coord] = self
    board[old_pos] = nil
  end

  def perform_jump(dx,dy)
    coord = [dx,dy]
    raise InvalidMoveError.new "Not valid move!" unless simple_jumps.include?(coord)
    old_pos = @pos # This makes calculating mid-point cleaner
    x, y = old_pos
    @pos = coord
    board[coord] = self
    board[old_pos] = nil
    mid_point = [(x + dx) / 2, (y + dy) / 2]
    board[mid_point] = nil
  end

  def perform_moves!(move_sequence)
    until move_sequence.empty?
      output = move_sequence.shift
      x, y = output
      diff = pos.first - x
      if (diff == 1 || diff == -1)
        self.perform_slide(x,y)
        board.render
      else
        self.perform_jump(x,y)
      end
    end
  end

  def valid_move_seq?(moves)
    begin
      test_board = board.dup
      x, y = pos
      test_board[[x,y]].perform_moves!(moves)
    rescue InvalidMoveError => e
      puts "This sequence of moves is invalid."
      puts "Error was: #{e.message}"
      return false
    end
    true
  end

  def perform_moves(moves)
    if valid_move_seq?(moves.dup)
      perform_moves!(moves)
    else
      raise InvalidMoveError.new "Try again!"
    end
  end
end
