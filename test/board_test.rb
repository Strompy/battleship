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

  def test_cell_count
    board = Board.new

    assert_equal 16, board.cells.count
  end

  def test_vaildate_coordinates
    board = Board.new

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_valid_placement

    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_coordinates_in_same_row?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.coordinates_in_same_row?(["A1", "A2"])
    assert_equal false, board.coordinates_in_same_row?(["A1", "C1"])
  end

  def test_coordinates_in_same_column?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.coordinates_in_same_column?(["A1", "C1"])
    assert_equal false, board.coordinates_in_same_column?(["A1", "A2"])
  end

  def test_coordinates_consecutive_numbers?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.coordinates_consecutive_numbers?(["A1", "A2"])
    assert_equal true, board.coordinates_consecutive_numbers?(["A2", "A3", "A4"])
    assert_equal false, board.coordinates_consecutive_numbers?(["C1", "B1"])
  end

  def test_coordinates_consecutive_letters?
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal true, board.coordinates_consecutive_letters?(["A1", "B1"])
    assert_equal true, board.coordinates_consecutive_letters?(["A1", "B1", "C1"])
    assert_equal false, board.coordinates_consecutive_letters?(["A1", "C1"])
    assert_equal false, board.coordinates_consecutive_letters?(["A1", "C1", "D1"])
  end

end
