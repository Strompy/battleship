require './lib/board'
require './lib/ship'
require './lib/cell'

class Setup
  attr_reader :player, :computer

  def initialize(player, computer)
    @player = player
    @computer = computer
  end

  def make_valid(ship)
    cells = []
    until @computer.valid_placement?(ship, cells) do
      cells = @computer.cells.keys.sample(3)
    end
  cells
  end
end
