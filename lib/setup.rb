require './lib/board'
require './lib/ship'
require './lib/cell'

class Setup
  attr_reader :player, :computer

  def initialize(player, computer)
    @player = player
    @computer = computer
  end
end
