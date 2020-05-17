require './lib/ship'

class Cell
  attr_reader :coordinate,
              :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if @ship != nil
      @ship.hit
    end
  end

  def render(visible = false)

      if !empty? && fired_upon? == true && @ship.sunk?
        "X"
      elsif @ship != nil && fired_upon? == true
        "H"
      elsif @ship == nil && fired_upon? == true
        "M"
      elsif visible == true && !empty? && fired_upon? == true && @ship.sunk?
        "X"
      elsif visible == true && @ship != nil && fired_upon? == true
        "H"
      elsif visible == true && @ship == nil && fired_upon? == true
        "M"
      elsif visible == true && @ship != nil
        "S"
<<<<<<< HEAD
      else
=======
      else #visible == true
>>>>>>> 8f499d50c6a9a2ab42a24bac32f279e569b8d4e6
        "."
      end
  end
end
