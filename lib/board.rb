require './lib/cell.rb'

class Board

  attr_accessor :board
  def initialize

    @board = Array.new(9) do |rows|
      Array.new(9) do |cells|
        Cell.new(cells, rows)
      end
    end
  end

end
