require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/setup'

class SetupTest < Minitest::Test
  def test_it_exists
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    setup - Setup.new
    assert_instance_of Setup, setup
  end
end
