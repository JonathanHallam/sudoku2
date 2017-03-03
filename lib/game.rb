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
          cell.possibilities = [cell.num]
        end
      end
    end
  end

  def remove_row_possibilities(board=game_world.board)
    board.each do |rows|
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
    remove_row_possibilities(game_world.board.transpose)
  end

  def remove_block_possibilities
    blocks = game_world.board.map{ |row| row.flatten.each_slice(3).to_a}.transpose.flatten.each_slice(9).to_a
    remove_row_possibilities(blocks)
  end

  def check_unique_cell_values
    game_world.board.each do |row|
      row.each do |cell|
        if cell.possibilities.length == 1
          cell.set = true
          cell.num = cell.possibilities[0]
          remove_row_possibilities
          remove_column_possibilities
          remove_column_possibilities
        end
      end
    end
    game_world.show_board
  end

  def check_unique_and_update_row_possibilities(board=game_world.board)
    board.each do |rows|
      possibilities_of_unset_cells = []
      rows.each do |cell|
        if cell.set == false
          possibilities_of_unset_cells << cell.possibilities
        end
      end
      possibilities_of_unset_cells.flatten!
      count_hash = possibilities_of_unset_cells.inject(Hash.new(0)) { |poss, count| poss[count] += 1; poss}
      count_hash.delete_if { |poss, count| count != 1}.each do |poss, count|
        rows.each do |cell|
          if cell.possibilities.include?(poss)
            cell.possibilities = [poss]
            cell.set = true
            cell.num = cell.possibilities[0]
            remove_row_possibilities
            remove_column_possibilities
            remove_column_possibilities
          end
        end
      end
      game_world.show_board
    end

  end

  def check_unique_and_update_column_possibilities
    check_unique_and_update_row_possibilities(game_world.board.transpose)
  end

  def check_unique_and_update_block_possibilities
    blocks = game_world.board.map{ |row| row.flatten.each_slice(3).to_a}.transpose.flatten.each_slice(9).to_a
    check_unique_and_update_row_possibilities(blocks)
  end

  def solve_that
    if game_world.show_board.flatten.include?(0)
      remove_row_possibilities
      remove_column_possibilities
      remove_block_possibilities
      check_unique_cell_values
      remove_row_possibilities
      remove_column_possibilities
      remove_block_possibilities
      check_unique_cell_values
      remove_row_possibilities
      remove_column_possibilities
      remove_block_possibilities
      check_unique_and_update_row_possibilities
      remove_row_possibilities
      remove_column_possibilities
      remove_block_possibilities
      check_unique_and_update_column_possibilities
      remove_row_possibilities
      remove_column_possibilities
      remove_block_possibilities
      check_unique_and_update_block_possibilities
      solve_that
    end
  end


end
