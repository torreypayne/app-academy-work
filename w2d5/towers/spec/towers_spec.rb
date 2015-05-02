require 'rspec'
require 'towers'

describe "Towers" do
  subject(:initial_tower) { [[5,4,3,2,1], [], []] }
  let(:game) { Towers.new }

  context "#initialize" do
    it "initializes the towers game" do
      expect(game.pegs).to eq(initial_tower)
    end
  end

  context "#valid_move?" do
    it "returns false if the move is invalid" do
      expect(game.valid_move?(1,2)).to be false
    end

    it "returns true if the move is valid" do
      expect(game.valid_move?(0,2)).to be true
    end
  end

  context "#move" do

    it "one move at a time" do
      game.move(0,2)
      expect(game.pegs).to eq([ [5,4,3,2], [], [1] ])
    end

    it "move only the upper disk of the stack" do
      game.move(0,2)
      expect(game.pegs.last).to eq([1])
    end

    it "doesnt move a bigger piece on top of a smaller one" do
      game.move(0,2)
      game.move(0,2)

      expect(game.pegs.last).to eq([1])
    end
  end

  context "winning condition" do
    # before(:each) do
      new_game = Towers.new(3)
      new_game.move(0,2)
      new_game.move(0,1)
      new_game.move(2,1)
      new_game.move(0,2)
      new_game.move(1,0)
      new_game.move(1,2)
      new_game.move(0,2)
    # end
    it "checks if winning condition is true" do
      expect(new_game.over?).to be true
    end

    it "checks if winning condition is false" do
      expect(game.over?).to be false
    end
  end
end
