require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test
  def test_it_exist
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_it_has_attributes
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
    assert_equal nil, cell.ship
  end

  def test_it_is_empty?
    cell = Cell.new("B4")

    assert_equal true, cell.empty?
  end
end