require 'card'
require 'deck'
require 'rspec'

describe "Deck" do
  subject(:deck) { Deck.new }

  context "start off with a real deck" do
    it "count deck size" do
      expect(deck.count).to eq(52)
    end

    it "Check the deck has cards of 4 suits" do

      expect(deck.suit_counts).to eq(4)
    end
  end

  context "play with the deck" do

    it "is able to draw a card object" do
      expect(deck.draw.first.class).to eq(Card)
    end

    it "is able to draw one card" do
      deck.draw
      expect(deck.count).to eq(51)
    end
  end

  context "the deck is fair" do
    let(:new_deck) { deck }

    it "is a new deck that is shuffled" do
      new_deck.shuffle
      expect(new_deck.draw).to_not eq(deck.draw)#pointer may be shuffled
    end
  end
end
