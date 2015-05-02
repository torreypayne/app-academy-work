require 'card'
require 'rspec'

describe "Cards" do

  context "Has a suit and a value" do

    let(:our_card) { Card.new(:clubs, 11) }

    it "has a suit" do
      expect(our_card.suit).to eq(:clubs)
    end

    it "has a value" do
      expect(our_card.value).to eq(11)
    end

    it "has a rank" do
      expect(our_card.rank).to eq(:jack)
    end
  end

  context "Cards know their value" do

    let(:lower) { Card.new(:spades, 8) }
    let(:higher) { Card.new(:hearts, 12) }

    it "knows King is higher than 8" do
      expect(higher.value).to be > lower.value
    end
  end
end
