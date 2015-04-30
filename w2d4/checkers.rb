class CheckersGame

  def initialize(player1, player2)
    @p1 = player1
    @p2 = player2
    @turn = :white
    board = Board.new
    board.set_board
  end

  def play
    until over?
      curr_player = @turn == :white ? @p1 : @p2
      curr_player.play_turn
      @turn = other_player(@turn)
    end

    puts "Game Over. #{curr_player.name} won!"
  end

  def other_player(turn)
    turn == white? :red : :white
  end
end
