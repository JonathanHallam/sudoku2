require './lib/board.rb'

describe Board do

  let!(:snow) {Board.new}

  it "should create a new board" do
    expect(snow.is_a?(Board)).to eql(true)
  end

  it "should respond to proper methods" do
    expect(snow.respond_to?(:board)).to eql(true)
    expect(snow.respond_to?(:rows)).to eql(true)
  end

  it "should initialize properly" do
    expect(snow.board.is_a?(Array)).to eql(true)
    expect(snow.board.flatten.length).to eql(81)
    expect(snow.rows.is_a?(Array)).to eql(true)
  end

  it "should populate the grid properly on ititialization" do
    snow.board.each do |rows|
      rows.each do |cells|
        expect(cells.is_a?(Cell)).to eql(true)
      end
    end
  end

  it "should show the board properly" do
    expect(snow.show_board).to eql([  [0, 0, 0, 0, 0, 0, 0, 0, 0],
                                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
                                      [0, 0, 0, 0, 0, 0, 0, 0, 0],
    ])
  end

end
