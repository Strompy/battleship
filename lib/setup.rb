require './lib/board'
require './lib/ship'
require './lib/cell'

class Setup
  def initialize(player1, player2)
    @player = player1
    @computer = player2
  end
end
