class Array

  def my_uniq
    return [] if self.empty?
    arr = []
    self.each { |el| arr << el if !arr.include?(el) }
    arr
  end

  def two_sum
    return [] if self.count < 2
    arr = []
    (0...self.size).each do |i|
      (i...self.size).each do |j|
        arr << [i, j] if self[i] + self[j] == 0 && i != j
      end
    end
    arr
  end

  def my_transpose
    arr = Array.new(self.size) { Array.new(self[0].size) }
    return self if self.size <= 1
    self.each_with_index do |els, row|
      els.each_with_index { |el, col| arr[col][row] = el }
    end

    arr
  end
end
