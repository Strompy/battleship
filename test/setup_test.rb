require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/setup'

class SetupTest < Minitest::Test
  def test_it_exists
    player = Board.new
    computer = Board.new
    setup = Setup.new(player, computer)
    assert_instance_of Setup, setup
  end
end
