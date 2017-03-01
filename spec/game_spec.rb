require './lib/game.rb'

describe Game do

  let!(:life) {Game.new}

  it "should initialize properly" do
    expect(life.is_a?(Game)).to eql(true)
    expect(life.game_world.is_a?(Board)).to eql(true)
    expect(life.set_values.is_a?(Array)).to eql(true)
  end

  it "should respond to proper methods" do
    expect(life.respond_to?(:game_world)).to eql(true)
    expect(life.respond_to?(:set_values)).to eql(true)
  end

  it "should set the set values on the game board properly" do
    game = Game.new(Board.new, [  [0, 0, 7], [0, 1, 6], [0, 4, 5], [0, 7, 8],
                                  [1, 0, 4], [1, 4, 3], [1, 6, 2],
                                  [2, 1, 3], [2, 2, 2], [2, 6, 4], [2, 8, 6],
                                  [3, 5, 8],
                                  [4, 2, 9], [4, 4, 6], [4, 6, 8],
                                  [5, 3, 2],
                                  [6, 0, 6], [6, 2, 8], [6, 6, 9], [6, 7, 1],
                                  [7, 2, 7], [7, 4, 4], [7, 8, 5],
                                  [8, 1, 2], [8, 4, 9], [8, 7, 3], [8, 8, 8]
                                  ])
    expect(game.game_world.show_board).to eql([ [7, 6, 0, 0, 5, 0, 0, 8, 0],
                                                [4, 0, 0, 0, 3, 0, 2, 0, 0],
                                                [0, 3, 2, 0, 0, 0, 4, 0, 6],
                                                [0, 0, 0, 0, 0, 8, 0, 0, 0],
                                                [0, 0, 9, 0, 6, 0, 8, 0, 0],
                                                [0, 0, 0, 2, 0, 0, 0, 0, 0],
                                                [6, 0, 8, 0, 0, 0, 9, 1, 0],
                                                [0, 0, 7, 0, 4, 0, 0, 0, 5],
                                                [0, 2, 0, 0, 9, 0, 0, 3, 8] ])
    end




end
