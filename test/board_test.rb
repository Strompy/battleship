require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/cell'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists

    assert_instance_of Board, @board
  end

  def test_cell_count

    assert_equal 16, @board.cells.count
  end

  def test_vaildate_coordinates

    assert_equal true, @board.valid_coordinate?("A1")
    assert_equal true, @board.valid_coordinate?("D4")
    assert_equal false, @board.valid_coordinate?("A5")
    assert_equal false, @board.valid_coordinate?("E1")
    assert_equal false, @board.valid_coordinate?("A22")
  end

  def test_valid_placement

    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2"])
    assert_equal false, @board.valid_placement?(@submarine, ["A2", "A3", "A4"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "A2", "A4"])
    assert_equal false, @board.valid_placement?(@submarine, ["A1", "C1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A3", "A2", "A1"])
    assert_equal false, @board.valid_placement?(@submarine, ["C1", "B1"])
    assert_equal false, @board.valid_placement?(@cruiser, ["A1", "B2", "C3"])
    assert_equal false, @board.valid_placement?(@submarine, ["C2", "D3"])
    assert_equal true, @board.valid_placement?(@submarine, ["A1", "A2"])
    assert_equal true, @board.valid_placement?(@cruiser, ["B1", "C1", "D1"])
  end

  def test_coordinates_in_same_row?

    assert_equal true, @board.coordinates_in_same_row?(["A1", "A2"])
    assert_equal false, @board.coordinates_in_same_row?(["A1", "C1"])
  end

  def test_coordinates_in_same_column?

    assert_equal true, @board.coordinates_in_same_column?(["A1", "C1"])
    assert_equal false, @board.coordinates_in_same_column?(["A1", "A2"])
  end

  def test_coordinates_consecutive_numbers?

    assert_equal true, @board.coordinates_consecutive_numbers?(["A1", "A2"])
    assert_equal true, @board.coordinates_consecutive_numbers?(["A2", "A3", "A4"])
    assert_equal false, @board.coordinates_consecutive_numbers?(["C1", "B1"])
  end

  def test_coordinates_consecutive_letters?

    assert_equal true, @board.coordinates_consecutive_letters?(["A1", "B1"])
    assert_equal true, @board.coordinates_consecutive_letters?(["A1", "B1", "C1"])
    assert_equal false, @board.coordinates_consecutive_letters?(["A1", "C1"])
    assert_equal false, @board.coordinates_consecutive_letters?(["A1", "C1", "D1"])
  end

  def test_place_ship
    @board.place(@cruiser, ["A1", "A2", "A3"])
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]

    assert_equal cell_1.ship, @cruiser
    assert_equal cell_2.ship, @cruiser
    assert_equal cell_3.ship, @cruiser
    assert_equal cell_2.ship, cell_3.ship
  end

  def test_if_overlapping_ships
    @board.place(@cruiser, ["A1", "A2", "A3"])

    assert_equal false, @board.valid_placement?(@submarine, ["A1", "B1"])
  end

  def test_it_can_render
    @board.place(@cruiser, ["A1", "A2", "A3"])
    board_f = "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n"
    board_t = "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n"
    require 'pry'; binding.pry
    assert_equal board_f, @board.render
    assert_equal board_t, @board.render(true)
  end

end
