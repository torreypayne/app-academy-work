require 'rspec'
require 'array'

describe "Array" do


  context "my_uniq returns uniq elements in the order in which they appeared" do

    it "returns an empty array" do
      expect([].my_uniq).to be_empty
    end

    it "handles a single element" do
      expect([1].my_uniq).to eq([1])
    end

    it "returns unique elements" do
      expect([3,3,2,2,1,1].my_uniq).to eq([3,2,1])
    end

    it "accurately accounts for dup non-adjacent elements" do
      expect([3,3,2,2,1,2,3].my_uniq).to eq([3,2,1])      
    end
  end

  context "sums two numbers and returns the pair of indices that sum to zero" do

    it "returns empty array if less than two elements" do
      expect([].two_sum).to be_empty
    end

    it "return empty set if array doesn't sum to zero" do
      expect([3,2,1].two_sum).to eq([])
    end

    it "return pairs of indices that sum to zero" do
      expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
    end

    it "returns smaller indices before larger ones" do
      expect([-1, 0, 2, -2, 1].two_sum).to_not eq([[2, 3], [0, 4]])
    end
  end

  context "#my_transpose" do

    let(:array) {
      [
        [0, 1, 2],
        [3, 4, 5],
        [2, 2, 2]
        ] }

    it "returns the empty array" do
      expect([].my_transpose).to eq([])
    end

    it "transpose one element array" do
      expect([1].my_transpose).to eq([1])
    end

    it "transposes a 2x2 matrix" do
      expect([[1,1],[2,2]].my_transpose).to eq([[1,2],[1,2]])
    end

    it "transposes a nasty matrix" do
      expect(array.my_transpose).to eq([[0,3, 2], [1,4,2], [2,5,2]])
    end
  end
end

describe "#stock_picker" do

  context "Stock Picker" do

    let(:stockprices) { [6,11,9,8,15,13,14,18,21,9,11,17] }

    it "knows when there is know profit made" do
      expect(stock_picker([3,2])).to be_empty
    end

    it "returns a valid index" do
      expect(stock_picker(stockprices)).to eq([0,8])
    end
  end
end
