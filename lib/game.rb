require 'board'

class Game

  attr_accessor :game_world, :set_values
  def initialize(game_world=Board.new, set_values=[])
    @game_world = game_world
    @set_values = set_values

    set_values.each do |seed|
      @game_world.board[seed[0]][seed[1]].num = seed[2]
    end

    game_world.board.each do |row|
      row.each do |cell|
        if cell.num != nil
          cell.set = true
        end
      end
    end
  end

  def remove_possibilities
    game_world.rows.flatten.each do |cells|
      if cells.set == true
        cells.possibilities = [cells.num]
      end
    end
  end

  def remove_row_possibilities
    game_world.board.each do |rows|
      set_cells = []
      rows.each do |cell|
        if cell.set == true
          set_cells << cell.num
        end
      end
      rows.each do |cell|
        if cell.set == false
          cell.possibilities = cell.possibilities - set_cells
        end
      end
    end
  end

  def remove_column_possibilities
    game_world.board.transpose.each do |columns|
      set_cells = []
      columns.each do |cell|
        if cell.set == true
          set_cells << cell.num
        end
      end
      columns.each do |cell|
        if cell.set == false
          cell.possibilities = cell.possibilities - set_cells
        end
      end
    end
  end

  def remove_block_possibilities

  end
end
