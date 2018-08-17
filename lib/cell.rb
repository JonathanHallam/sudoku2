class Cell

  attr_accessor :col, :row, :set, :possibilities, :block, :num
  def initialize(row, col)
    @col = col
    @row = row
    @block = self.set_block

    @num = num
    @set = false
    @possibilities = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def set_block
    if [0, 1, 2].include?(@col) && [0, 1, 2].include?(@row)
      @block = 1
    elsif [3, 4, 5].include?(@col) && [0, 1, 2].include?(@row)
      @block = 2
    elsif [6, 7, 8].include?(@col) && [0, 1, 2].include?(@row)
      @block = 3
    elsif [0, 1, 2].include?(@col) && [3, 4, 5].include?(@row)
      @block = 4
    elsif [3, 4, 5].include?(@col) && [3, 4, 5].include?(@row)
      @block = 5
    elsif [6, 7, 8].include?(@col) && [3, 4, 5].include?(@row)
      @block = 6
    elsif [0, 1, 2].include?(@col) && [6, 7, 8].include?(@row)
      @block = 7
    elsif [3, 4, 5].include?(@col) && [6, 7, 8].include?(@row)
      @block = 8
    elsif [6, 7, 8].include?(@col) && [6, 7, 8].include?(@row)
      @block = 9
    end
  end

  def set_possibility(value)
    @possibilities = [value]
    @set = true
    @num = @possibilities[0]
  end
end
