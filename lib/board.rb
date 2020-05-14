require './lib/cell'
require './lib/ship'

class Board
  attr_reader :cells
  def initialize
    @cells = {
    "A1" => Cell.new("A1"),
    "A2" => Cell.new("A2"),
    "A3" => Cell.new("A3"),
    "A4" => Cell.new("A4"),
    "B1" => Cell.new("B1"),
    "B2" => Cell.new("B2"),
    "B3" => Cell.new("B3"),
    "B4" => Cell.new("B4"),
    "C1" => Cell.new("C1"),
    "C2" => Cell.new("C2"),
    "C3" => Cell.new("C3"),
    "C4" => Cell.new("C4"),
    "D1" => Cell.new("D1"),
    "D2" => Cell.new("D2"),
    "D3" => Cell.new("D3"),
    "D4" => Cell.new("D4")
    }
  end

  def valid_coordinate?(cell)
    @cells.keys.any?(cell)
  end

  def coordinate_letters(coordinates)
    coordinates.map do |coordinate|
      coordinate[0]
    end
  end

  def coordinate_numbers(coordinates)
    coordinates.map do |coordinate|
      coordinate[1].to_i
    end
  end

  def coordinates_in_same_row?(coordinates)
    letters = coordinate_letters(coordinates)
    letters.uniq.length == 1
  end

  def coordinates_in_same_column?(coordinates)
    numbers = coordinate_numbers(coordinates)
    numbers.uniq.length == 1
  end

  def coordinates_consecutive_letters?(coordinates)
    coordinate_letters(coordinates).each_cons(2).all? do |a, b|
      b.ord == (a.ord + 1)
    end
  end

  def coordinates_consecutive_numbers?(coordinates)
    coordinate_numbers(coordinates).each_cons(2).all? do |a, b|
      b == a + 1
    end
  end

  def valid_placement?(ship, coordinates)
    ship.length == coordinates.count

  # consecutive numbers
  # consecutive letters
  end

end
