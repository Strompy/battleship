require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @player1 = Board.new
    @player2 = Board.new
    @game = Game.new(@player1, @player2)
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_equal @player1, @game.player
    assert_equal @player2, @game.computer
  end

  def test_computer_valid_placement
    expected = @player2.place(@cruiser, ["A1", "B3", "D4"])
    assert_equal false, @player2.valid_placement?(@cruiser, expected)

    expected = @game.make_valid(@cruiser)
    assert_equal true, @player2.valid_placement?(@cruiser, expected)

    expected = @game.make_valid(@submarine)
    assert_equal true, @player2.valid_placement?(@submarine, expected)
  end

  def test_computer_place_ship
    expected = @player2.render(true)
    @game.computer_place(@cruiser)
    @game.computer_place(@submarine)

    refute_equal expected, @player2.render(true)
    assert_equal 5,  @player2.render(true).count("S")
  end

  def test_computer_can_fire
    @game.computer_fire("B2")

    assert_equal true, @player1.cells["B2"].fired_upon?
    assert_equal false, @player1.cells["C2"].fired_upon?
    assert_equal "M", @player1.cells["B2"].render
  end

  def test_random_cell_fired_upon?
    cell = @game.computer_picks_cell

    assert_equal true, @player1.cells[cell].fired_upon?
  end

end
