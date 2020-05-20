require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'

class GameTest < Minitest::Test
  def setup
    # @cruiser = Ship.new("Cruiser", 3)
    # @submarine = Ship.new("Submarine", 2)
    # @player1 = Board.new
    # @player2 = Board.new
    @game = Game.new
  end

  def test_it_exists
    assert_instance_of Game, @game
  end

  def test_it_has_attributes
    assert_instance_of Board, @game.player
    assert_instance_of Board, @game.computer
    assert_equal "Submarine", @game.submarine_computer.name
    assert_equal "Submarine", @game.submarine_player.name
    assert_equal "Cruiser", @game.cruiser_computer.name
    assert_equal "Cruiser", @game.cruiser_player.name
  end

  def test_computer_valid_placement
    expected = ["A1", "B3", "D4"]
    assert_equal false, @game.computer.valid_placement?(@game.cruiser_computer, expected)

    expected = @game.make_valid(@game.cruiser_computer)
    assert_equal true, @game.computer.valid_placement?(@game.cruiser_computer, expected)

    expected = @game.make_valid(@game.submarine_computer)
    assert_equal true, @game.computer.valid_placement?(@game.submarine_computer, expected)
  end

  def test_computer_place_ship
    @game.computer_place(@game.cruiser_computer)
    @game.computer_place(@game.submarine_computer)

    assert_equal 5,  @game.computer.render(true).count("S")
  end

  def test_computer_can_fire
    @game.computer_fire("B2")

    assert_equal true, @game.player.cells["B2"].fired_upon?
    assert_equal false, @game.player.cells["C2"].fired_upon?
    assert_equal "M", @game.player.cells["B2"].render
  end

  def test_random_cell_fired_upon?

    cell = @game.computer_picks_cell

    assert_equal true, @game.player.cells[cell].fired_upon?
  end

  def test_game_start
    skip
    @game.game_start
    # assert_equal "p", @game.player.gets.chomp!
  end

  def test_player_turn
    skip
    @game.player_turn
  end

end
