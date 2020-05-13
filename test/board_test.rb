require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/cell'

class BoardTest < Minitest::Test
  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_vaildate_coordinates
    board = Board.new

    assert_equal true, board.valid_coordinate?("A1")
  end
end
