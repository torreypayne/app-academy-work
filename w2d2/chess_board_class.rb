require_relative 'piece_class.rb'
require_relative 'indiv_pieces.rb'
require 'byebug'

class ChessBoard
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def deep_dup # "#deep_dup" ??
  end

  def [](pos)
    row, col = pos[0], pos[1]
    @grid[row][col]
  end

  def []=(pos, piece)
    # raise "Already occupied!" unless empty?(pos)

    row, col = pos[0], pos[1]
    @grid[row][col] = piece
  end

  def set_board
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    #set black back row

    @grid[0].each_index do |idx|
      self[[0, idx]] = back_row[idx].new(self, :black, [0, idx])
    end

    @grid[7].each_index do |idx|
      self[[7, idx]] = back_row[idx].new(self, :white, [7, idx])
    end

    @grid[1].each_index do |idx|
      self[[1, idx]] = Pawn.new(self, :black, [1, idx])
    end

    @grid[6].each_index do |idx|
      self[[6, idx]] = Pawn.new(self, :white, [6, idx])
    end
  end

  def display
    @grid.each do |row|
      row.each do |piece|
        if piece.is_a?(Pawn)
          print 'P '
        elsif piece.is_a?(Rook)
          print 'R '
        elsif piece.is_a?(King)
          print 'K '
        elsif piece.is_a?(Queen)
          print 'Q '
        elsif piece.is_a?(Bishop)
          print 'B '
        elsif piece.is_a?(Knight)
          print 'N '
        else
          print '_ '
        end
      end
      print "\n"
    end
  end

  def check_all_tiles(&prc)
    @grid.each do |row|
      row.each do |tile|
        prc.call(tile)
      end
    end
  end

  def move(start_pos, end_pos)
  end

  def on_board?(pos)
    pos.none? {|coord| coord < 0 || coord > 7 }
  end

  def occupied?(pos)
    !self[pos].nil?
  end

  def piece_at(pos)
    # :knight ??
  end

  def check?(color)
    king_pos = nil

    check_all_tiles do |tile|
      if tile.is_a?(King) && tile.color == color
        king_pos = tile.pos
        break
      end
    end

    check_all_tiles do |tile|
      if !tile.nil?
        # debugger
        if tile.initial_moves.any? { |move| move == king_pos }
          return true
        end
      end
    end

    return false
  end

  def check_mate?(color)
  end

end

grid = ChessBoard.new
grid.set_board
grid.display
puts grid.check?(:black)
