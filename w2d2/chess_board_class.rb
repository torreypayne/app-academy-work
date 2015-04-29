require_relative 'piece_class.rb'
require_relative 'indiv_pieces.rb'
require 'byebug'

class ChessBoard
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
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

  def each_tile(&prc)
    @grid.each do |row|
      row.each do |tile|
        prc.call(tile)
      end
    end
  end

  def deep_dup # "#deep_dup" ??'
    new_board = ChessBoard.new
    #make empty board
    new_board.each_tile do |piece|
      dup_piece(piece, new_board) if piece
    end
    #check all tiles
    #dup all pieces, passing in new board
    new_board
  end

  def dup_piece(piece, new_board)
    piece.class.new(new_board, piece.color, piece.pos.dup)
  end

  def move(start_pos, end_pos)
    piece = self[start_pos]
    # debugger
    raise "No piece here!" if piece.nil?
    if piece.valid_moves.include?(end_pos)
      piece.pos = end_pos
      piece.moved = true
      self[end_pos] = piece
      self[start_pos] = nil
    else
      raise "Not a valid move"
    end
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

  def in_check?(color)
    king_pos = nil

    each_tile do |tile|
      if tile.is_a?(King) && tile.color == color
        king_pos = tile.pos
        break
      end
    end

    each_tile do |tile|
      if !tile.nil?
        # debugger
        if tile.initial_moves.any? { |move| move == king_pos }
          return true
        end
      end
    end

    return false
  end

  def checkmate?(color)
    if in_check?(color)
      my_pieces = []
      self.each_tile do |tile|
        my_pieces << tile if tile.color == color
      end
      my_pieces.each do |piece|
        return false unless piece.valid_moves.empty?
      end
    end

    true
  end

end

# f2, f3
# e7, e5
# g2, g4
# d8, h4

grid = ChessBoard.new
grid.set_board
grid.display
# puts grid.in_check?(:black)
grid.move( [1,5], [2,5])
grid.display
grid.move( [6,4], [4,4])
grid.display
grid.move( [1,6], [3,6])
grid.display
grid.move( [7,3], [3,7])
grid.display
p grid.checkmate?(:black)
p grid.checkmate?(:white)
