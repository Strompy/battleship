require './lib/ship'

class Cell
  attr_reader :coordinate

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
  end

end
