class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) }
  end

  def render
    @grid.each do |row|
      row.each do |tile|
        if tile.nil?
          print '_'
          next
        end
        print 'R' if tile.color == :red
        print 'W' if tile.color == :white
      end
      puts "\n"
    end
    puts "-----------------------"
  end

  def set_board
    [0, 1, 2, 5, 6, 7].each do |row|
      if [0, 1, 2].include?(row)
        (0...8).to_a.each do |col|
          pos = [row, col]
          if (row == 0 || row == 2)
            @grid[row][col] = Piece.new(self, :white, pos) if col.odd?
          else
            @grid[row][col] = Piece.new(self, :white, pos) if col.even?
          end
        end
      elsif (5...8).to_a.include?(row)
        (0...8).to_a.each do |col|
          pos = [row, col]
          if (row == 5 || row == 7)
            @grid[row][col] = Piece.new(self, :red, pos) if col.even?
          else
            @grid[row][col] = Piece.new(self, :red, pos) if col.odd?
          end
        end
      end
    end
  end

  def [](pos)
    row, col = pos.first, pos.last
    @grid[row][col]
  end

  def []=(pos, new_tile)
    row, col = pos.first, pos.last
    @grid[row][col] = new_tile
  end

  def on_board?(pos)
    pos.first >= 0 && pos.first < 8 && pos.last >= 0 && pos.last < 8
  end

  def tile_at(pos)
    @grid[pos]
  end

  def occupied?(pos)
    !@grid[pos].nil?
  end

  def dup
    new_board = Board.new
    new_board.grid.each_with_index do |row, r_idx|
      row.each_with_index do |tiles, c_idx|
        mirror = @grid[r_idx][c_idx]
        position = [r_idx, c_idx]
        if !mirror.nil?
          new_board.grid[r_idx][c_idx] = Piece.new(new_board, mirror.color, position)
        end
      end
    end

    new_board
  end


  def perform_moves!(move_sequence)
    # Takes sequence/array of positions that are eligible to be popped & exec'ed.

  end
end
