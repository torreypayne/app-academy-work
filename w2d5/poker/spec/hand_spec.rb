require 'hand'
require 'rspec'

describe "Hand" do
  subject(:hand) { Hand.new }

  context "initialize hand of 5 cards" do
    it "is five cards" do
      expect(hand.cards).to eq(5)
    end
  end

  context "evaluate correct hands" do
    let(:deck) {Deck.new}

    it "evaluate two pair" do
      expect(Hand.evalute([1,2,3,4,4])).to eq(:two_pair)
    end
  end
end
