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
    require 'pry'; binding.pry

    refute_equal expected, @player2.render(true)
    assert_equal 5,  @player2.render(true).count("S")
  end

end
