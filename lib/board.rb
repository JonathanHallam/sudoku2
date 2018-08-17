require './lib/cell.rb'

class Board

  attr_accessor :board, :rows, :columns, :blocks
  def initialize
    @board =  Array.new(9) do |rows|
                Array.new(9) do |cells|
                  Cell.new(cells, rows)
                end
              end
    @rows = @board
    @columns = @board.transpose
    @blocks = @board.map{ |row| row.flatten.each_slice(3).to_a}.transpose.flatten.each_slice(9).to_a
  end

  def show_board
    puts
    puts "--+---+---+---+---+---+---+---+---"
    visible = []
    @board.each do |row|
      row.each do |cell|
        if cell.set == true
          visible << cell.num
        else
          visible << 0
        end
      end
    end
    visible.each_slice(9).to_a.each do |row|
      puts row.each { |cell| cell }.join(" | ")
      puts "--+---+---+---+---+---+---+---+---"
    end
  end
end
