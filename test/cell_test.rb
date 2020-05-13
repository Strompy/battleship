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

  def test_it_has_a_ship
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
    assert_equal false, cell.empty?
  end

  def test_fired_upon?
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal false, cell.fired_upon?
    cell.fire_upon

    assert_equal 2, cell.ship.health
    assert_equal true, cell.fired_upon?
  end

  def test_it_can_render_miss
    cell = Cell.new("B4")

    assert_equal ".", cell.render

    cell.fire_upon

    assert_equal "M", cell.render
  end

  def test_it_can_render_hit
    cell = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal ".", cell.render
    assert_equal "S", cell.render(true)

    cell.fire_upon
    assert_equal "H", cell.render
    assert_equal false, cruiser.sunk?

    cruiser.hit
    cruiser.hit

    assert_equal true, cruiser.sunk?
    assert_equal "X", cell.render
  end

end
