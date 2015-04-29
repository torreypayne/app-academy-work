require_relative './pieces'
require 'byebug'
require 'colorize'

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
    puts "    a b c d e f g h"
    puts "    ---------------"
    @grid.each_with_index do |row, row_idx|
      print (row_idx + 1).to_s + " | "
      row.each_with_index do |piece, col_idx|
        if piece.nil?
          if (row_idx + col_idx).even?
            print "  ".colorize(background: :red) #dark square (black)
          else
            print "  ".colorize(background: :cyan) #light square (white)
          end
        else
          if (row_idx + col_idx).even?
            print piece.display.colorize(background: :red, color: piece.color)
          else
            print piece.display.colorize(background: :cyan, color: piece.color)
          end
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

  def deep_dup
    new_board = ChessBoard.new
    self.each_tile do |piece|
      new_board[piece.pos] = dup_piece(piece, new_board) if piece
    end
    # p new_board
    new_board
  end

  def dup_piece(piece, new_board)
    piece.class.new(new_board, piece.color, piece.pos.dup, piece.moved)
  end

  def move(start_pos, end_pos)
    piece = self[start_pos]
    # print "turn: "
    # p piece.color
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

  def move!(start_pos, end_pos)
    # p self
    tile = self[start_pos]
    # p tile
    tile.pos = end_pos
    self[start_pos], self[end_pos] = nil, tile
  end

  def on_board?(pos)
    pos.none? {|coord| coord < 0 || coord > 7 }
  end

  def occupied?(pos)
    !self[pos].nil?
  end

  def in_check?(color)
    # king_pos = nil

    king_pos = king(color)

    pieces(other_color(color)).each do |piece|
      return true if piece.initial_moves.any? { |move| move == king_pos }
    end

    # each_tile do |tile|
    #   if tile.is_a?(King) && tile.color == color
    #     king_pos = tile.pos
    #     break
    #   end
    # end

    # each_tile do |tile|
    #   if !tile.nil? && tile.color != color
    #     if tile.valid_moves.any? { |move| move == king_pos }
    #       return true
    #     end
    #   end
    # end

    false
  end

  def checkmate?(color)
    # p in_check?(color)
    if in_check?(color)
      # my_pieces = []
      # self.each_tile do |tile|
      #   next if tile.nil?
      #   my_pieces << tile if tile.color == color
      # end
      pieces(color).each do |piece|
        # p piece.class
        # p piece.pos
        # p piece.valid_moves
        return false unless piece.valid_moves.empty?
      end

      true
    else
      false
    end
  end

  def king(color)
    king_tile = pieces(color).find { |piece| piece.is_a?(King) }
    king_tile.pos
  end

  def pieces(color)
    my_pieces = []

    each_tile do |tile|
      my_pieces << tile if !tile.nil? && tile.color == color
    end

    my_pieces
  end

  def other_color(color)
    color == :black ? :white : :black
  end

end

# f2, f3
# e7, e5
# g2, g4
# d8, h4

grid = ChessBoard.new
grid.set_board
grid.display
grid.move( [1,5], [2,5])
grid.display
grid.move( [6,4], [4,4])
grid.display
grid.move( [1,6], [3,6])
grid.display
grid.move( [7,3], [3,7])
grid.display
p grid.checkmate?(:white)
