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


end
