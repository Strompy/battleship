require './lib/board'
require './lib/ship'
require './lib/cell'

class Game
  attr_reader :player, :computer

  def initialize(player, computer)
    @player = player
    @computer = computer
  end

  def make_valid(ship)
    cells = []
    until @computer.valid_placement?(ship, cells) do
      cells = @computer.cells.keys.sample(ship.length)
    end
  cells
  end

  def computer_place(ship)
    @computer.place(ship, make_valid(ship))
  end

  def computer_fire(cell)
    @player.cells[cell].fire_upon
  end

  def computer_picks_cell
    cell = @player.cells.values.sample(1)
    until cell[0].fired_upon? == false do
      cell = @player.cells.values.sample(1)
    end
    computer_fire((cell[0].coordinate))
    cell[0].coordinate
  end
end
