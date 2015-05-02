require 'hand'
require 'deck'
require 'rspec'

describe "Hand" do
  let(:deck) {Deck.new}
  subject(:hand) { Hand.new(deck) }

  context "initialize hand of 5 cards" do
    it "is five cards" do
      expect(hand.cards).to eq(5)
    end
  end

  context "evaluate correct hands" do

    it "evaluate two pair" do
      expect(hand.evaluate).to_not eq(nil)
    end
  end
end
