require './lib/board'
require 'pry'

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
          cell.possibilities = [cell.num]
        end
      end
    end
  end

  def remove_possibilities(set)
    definate_values = set.select { |cell| cell.num != nil }.map { |cell| cell.num }
    set.each { |cell| cell.possibilities -= definate_values unless cell.set }
  end

  def remove_all_possibilities
    orientations = [@game_world.rows, @game_world.columns, @game_world.blocks]
    orientations.each do |orientation|
      orientation.each { |slice| remove_possibilities(slice) }
    end
  end

  def check_unique_cell_values
    game_world.board.each do |row|
      row.each do |cell|
        if cell.possibilities.length == 1
          cell.set = true
          cell.num = cell.possibilities[0]
          remove_all_possibilities
        end
      end
    end
    game_world.show_board
  end

  def check_unique_and_update_possibilities(set)
    possibilities = set.select { |cell| !cell.set }.map {|cell| cell.possibilities}.flatten
    count_hash = possibilities.inject(Hash.new(0)) { |poss, count| poss[count] += 1; poss}  
    count_hash.delete_if { |poss, count| count != 1}.keys.each do |poss|
      set.each do |cell|
        if cell.possibilities.include?(poss)
          cell.set_possibility(poss)
          remove_all_possibilities
        end
      end
    end
    check_unique_cell_values
  end

  def check_unique_and_update_all_possibilities
    orientations = [@game_world.rows, @game_world.columns, @game_world.blocks]
    orientations.each do |orientation|
      orientation.each { |slice| check_unique_and_update_possibilities(slice) }
    end
  end

  def solve_that
    if game_world.show_board.flatten.include?(0)
      check_unique_and_update_all_possibilities
      solve_that
    end
  end
end
