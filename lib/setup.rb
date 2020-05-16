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
    until @computer.valid_placement?(ship, cells) == true do
      cells = @computer.cells.keys.sample(3)
      @computer.valid_placement?(ship, cells)
    end
    @computer.place(ship, cells)
  end
end
