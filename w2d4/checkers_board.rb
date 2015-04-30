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
  end

  def set_board
    @grid[0].each_with_index do |row_1_tile, col|
      @grid[0][col] = Piece.new(self, :white, [0, col]) if col.odd?
    end
    @grid[1].each_with_index do |row_2_tile, col|
      @grid[1][col] = Piece.new(self, :white, [1, col]) if col.even?
    end
    @grid[2].each_with_index do |row_3_tile, col|
      @grid[2][col] = Piece.new(self, :white, [2, col]) if col.odd?
    end
    @grid[5].each_with_index do |row_1_tile, col|
      @grid[5][col] = Piece.new(self, :red, [5, col]) if col.even?
    end
    @grid[6].each_with_index do |row_1_tile, col|
      @grid[6][col] = Piece.new(self, :red, [6, col]) if col.odd?
    end
    @grid[7].each_with_index do |row_1_tile, col|
      @grid[7][col] = Piece.new(self, :red, [7, col]) if col.even?
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

  def occupied(pos)
    @grid[pos]
  end

  def occupied?(pos)
    @grid[pos].nil?
  end
end
