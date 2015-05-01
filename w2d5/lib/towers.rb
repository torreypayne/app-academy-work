class Towers

  attr_reader :pegs

  def initialize(num = 5)
    @pegs = Array.new(3) { Array.new }
    @pegs[0] = 1.upto(num).to_a.reverse
  end

  def valid_move?(x,y)
    return false if @pegs[x].empty?
    return false if !@pegs[y].empty? && @pegs[x].last > @pegs[y].last
    true
  end

  def move(x,y)
    @pegs[y] << @pegs[x].pop if valid_move?(x,y)
  end

  def play
    @pegs.display
    until over?
      display
      move = prompt
      game.move(move.first, move.last)
    end

    puts "You won!"
  end

  def self.display
    print @pegs
  end

  def prompt
    puts "Make a move! (from, to)"
    move = gets.chomp.to_a.map { |el| el.to_i }
  end

  def over?
    @pegs[0].empty? && (@pegs[1].empty? || @pegs[2].empty?)
  end
end
