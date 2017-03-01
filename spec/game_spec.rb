require './lib/game.rb'

describe Game do

  let!(:life) {Game.new}
  let!(:game) {@game = Game.new(Board.new, [  [0, 0, 7], [0, 1, 6], [0, 4, 5], [0, 7, 8],
                                              [1, 0, 4], [1, 4, 3], [1, 6, 2],
                                              [2, 1, 3], [2, 2, 2], [2, 6, 4], [2, 8, 6],
                                              [3, 5, 8],
                                              [4, 2, 9], [4, 4, 6], [4, 6, 8],
                                              [5, 3, 2],
                                              [6, 0, 6], [6, 2, 8], [6, 6, 9], [6, 7, 1],
                                              [7, 2, 7], [7, 4, 4], [7, 8, 5],
                                              [8, 1, 2], [8, 4, 9], [8, 7, 3], [8, 8, 8]  ])}
  let!(:game2) {@game = Game.new(Board.new, [ [0, 0, 7], [0, 1, 6], [0, 4, 5], [0, 7, 8],
                                              [1, 0, 4], [1, 4, 3], [1, 6, 2],
                                              [2, 1, 3], [2, 2, 2], [2, 6, 4], [2, 8, 6],
                                              [3, 5, 8],
                                              [4, 2, 9], [4, 4, 6], [4, 6, 8],
                                              [5, 3, 2],
                                              [6, 0, 6], [6, 2, 8], [6, 6, 9], [6, 7, 1],
                                              [7, 2, 7], [7, 4, 4], [7, 8, 5],
                                              [8, 1, 2], [8, 4, 9], [8, 7, 3], [8, 8, 8]  ])}
  let!(:game3) {@game = Game.new(Board.new, [ [0, 0, 7], [0, 1, 6], [0, 4, 5], [0, 7, 8],
                                              [1, 0, 4], [1, 4, 3], [1, 6, 2],
                                              [2, 1, 3], [2, 2, 2], [2, 6, 4], [2, 8, 6],
                                              [3, 5, 8],
                                              [4, 2, 9], [4, 4, 6], [4, 6, 8],
                                              [5, 3, 2],
                                              [6, 0, 6], [6, 2, 8], [6, 6, 9], [6, 7, 1],
                                              [7, 2, 7], [7, 4, 4], [7, 8, 5],
                                              [8, 1, 2], [8, 4, 9], [8, 7, 3], [8, 8, 8]  ])}


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

  it "should remove possibilities if the value is set" do
    game.remove_possibilities
    expect(game.game_world.board[0][0].possibilities.length).to eql(1)
    expect(game.game_world.board[0][2].possibilities.length).to eql(9)
  end

  it "should remove possibilities based on what's in the row" do
    game.remove_row_possibilities
    expect(game.game_world.board[0][2].possibilities).to eql([1, 2, 3, 4, 9])
    expect(game.game_world.board[1][1].possibilities).to eql([1, 5, 6, 7, 8, 9])
  end

  it "should remove possibilities based on what's in the column" do
    game2.remove_column_possibilities
    expect(game2.game_world.board[0][2].possibilities).to eql([1, 3, 4, 5, 6])
    expect(game2.game_world.board[1][1].possibilities).to eql([1, 4, 5, 7, 8, 9])
  end

  it "should remove possibilities based on what's in the blocks" do
    game3.remove_block_possibilities
    expect(game3.game_world.board[4][6].possibilities).to eql([1, 2, 3, 5, 6, 7, 8])
    expect(game3.game_world.board[8][3].possibilities).to eql([1, 3, 4, 5, 9])
  end



end
