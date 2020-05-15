require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/setup'

class SetupTest < Minitest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @player = Board.new
    @computer = Board.new
    @setup = Setup.new(@player, @computer)
  end

  def test_it_exists
    assert_instance_of Setup, @setup
  end
end
