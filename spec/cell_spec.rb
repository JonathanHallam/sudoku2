require './lib/cell.rb'

describe Cell do

  let!(:splinter) {Cell.new(0, 0)}

  it "should create a new cell" do
    expect(splinter.is_a?(Cell)).to eql(true)
  end

  it "should respond to proper methods" do
    expect(splinter.respond_to?(:col)).to eql(true)
    expect(splinter.respond_to?(:row)).to eql(true)
    expect(splinter.respond_to?(:block)).to eql(true)
    expect(splinter.respond_to?(:set)).to eql(true)
    expect(splinter.respond_to?(:possibilities)).to eql(true)
  end

  it "should initialize properly" do
    expect(splinter.row).to eql(0)
    expect(splinter.col).to eql(0)
    expect(splinter.set).to eql(false)
    expect(splinter.possibilities.is_a?(Array)).to eql(true)
  end

  it "should set the appropriate block on initialization" do
    block_one = Cell.new(0, 0)
    block_five = Cell.new(5, 5)
    block_six = Cell.new(5, 6)
    block_seven = Cell.new(8, 2)
    expect(block_one.block).to eql(1)
    expect(block_five.block).to eql(5)
    expect(block_six.block).to eql(6)
    expect(block_seven.block).to eql(7)
  end

end
