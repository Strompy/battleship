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
    @player1 = Board.new
    @player2 = Board.new
    @setup = Setup.new(@player1, @player2)
  end

  def test_it_exists
    assert_instance_of Setup, @setup
  end

  def test_it_has_attributes
    assert_equal @player1, @setup.player
    assert_equal @player2, @setup.computer
  end

  def test_computer_ship_placement
    expected = nil
    expected = @player2.cells.keys.shuffle
    require 'pry'; binding.pry
    assert_equal false, @player2.valid_placement?(@cruiser, expected[0..2])
  end
end
