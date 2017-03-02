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
  let!(:hard_problem) {@game = Game.new(Board.new, [  [0, 0, 1], [0, 4, 7], [0, 7, 3], [0, 8, 2],
                                                      [1, 0, 8], [1, 1, 3], [1, 3, 6],
                                                      [2, 2, 2], [2, 3, 9], [2, 6, 6], [2, 8, 8],
                                                      [3, 0, 6], [3, 5, 4], [3, 6, 9], [3, 8, 7],
                                                      [4, 1, 9], [4, 7, 5],
                                                      [5, 0, 3], [5, 2, 7], [5, 3, 5], [5, 8, 4],
                                                      [6, 0, 2], [6, 2, 3], [6, 5, 9], [6, 6, 1],
                                                      [7, 5, 2], [7, 7, 4], [7, 8, 3],
                                                      [8, 0, 7], [8, 1, 4], [8, 4, 8], [8, 8, 9]
    ])}
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

  it "should remove possibilities if the value is set on initialization" do
    expect(game.game_world.board[0][0].possibilities.length).to eql(1)
    expect(game.game_world.board[0][2].possibilities.length).to eql(9)
  end

  it "should remove possibilities based on what's in the row" do
    game.remove_row_possibilities
    expect(game.game_world.board[0][2].possibilities).to eql([1, 2, 3, 4, 9])
    expect(game.game_world.board[1][1].possibilities).to eql([1, 5, 6, 7, 8, 9])
  end

  it "should remove possibilities based on what's in the column" do
    game.remove_column_possibilities
    expect(game.game_world.board[0][2].possibilities).to eql([1, 3, 4, 5, 6])
    expect(game.game_world.board[1][1].possibilities).to eql([1, 4, 5, 7, 8, 9])
  end

  it "should remove possibilities based on what's in the blocks" do
    game.remove_block_possibilities
    expect(game.game_world.board[4][7].possibilities).to eql([1, 2, 3, 4, 5, 6, 7, 9])
    expect(game.game_world.board[8][2].possibilities).to eql([1, 3, 4, 5, 9])
  end

  it "should remove possibilities from all three" do
    game.remove_row_possibilities
    game.remove_column_possibilities
    game.remove_block_possibilities
    expect(game.game_world.board[3][6].possibilities).to eql([1, 3, 5, 6, 7])
    expect(game.game_world.board[5][7].possibilities).to eql([4, 5, 6, 7, 9])
  end

  it "should check to see if any cell have new unique possibilities and remove set possibilities from other " do
    game.remove_row_possibilities
    game.remove_column_possibilities
    game.remove_block_possibilities
    game.check_unique_cell_values
    expect(game.game_world.board[0][2].possibilities).to eql([1])
    expect(game.game_world.board[0][2].set).to eql(true)
    expect(game.game_world.board[0][2].num).to eql(1)
  end

  it "should search through the possibilities for all cells in a row for unique values" do
    game.remove_row_possibilities
    game.remove_column_possibilities
    game.remove_block_possibilities
    game.check_unique_and_update_row_possibilities
    expect(game.game_world.board[0][5].possibilities).to eql([2])
    expect(game.game_world.board[0][5].set).to eql(true)
    expect(game.game_world.board[0][5].num).to eql(2)
  end

  it "should search through the possibilities for all cells in a column for unique values" do
    game.remove_row_possibilities
    game.remove_column_possibilities
    game.remove_block_possibilities
    game.check_unique_and_update_column_possibilities
    expect(game.game_world.board[0][0].num).to eql(7)
  end

  it "should search through the possibilities for all cells in a block for unique values" do
    game.remove_row_possibilities
    game.remove_column_possibilities
    game.remove_block_possibilities
    game.check_unique_and_update_block_possibilities
    expect(game.game_world.board[6][8].num).to eql(4)
  end

  it "should loop all this until it's finished" do
    game.solve_that
    expect(game.game_world.show_board.flatten.include?(0)).to eql(false)
  end

  it "should solve hard problems too!" do
    hard_problem.solve_that
    expect(hard_problem.game_world.show_board.flatten.include?(0)).to eql(false)
  end



end
