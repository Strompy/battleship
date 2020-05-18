require './lib/board'
require './lib/ship'
require './lib/cell'

class Game
  attr_reader :player, :computer

  def initialize
    @player = Board.new
    @computer = Board.new
    @submarine_computer = Ship.new("Submarine", 2)
    @cruiser_computer = Ship.new("Cruiser", 3)
    @submarine_player = Ship.new("Submarine", 2)
    @cruiser_player = Ship.new("Cruiser", 3)
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
    if @player.cells[cell].ship == nil
      puts "My shot on #{cell} was a miss."
    elsif @player.cells[cell].ship != nil
      puts "My shot on #{cell} was a hit."
      if @player.cells[cell].ship.sunk?
        puts "I sunk your #{@player.cells[cell].ship.name}!"
      end
    end
  end

  def computer_picks_cell
    cell = @player.cells.values.sample(1)
    until cell[0].fired_upon? == false do
      cell = @player.cells.values.sample(1)
    end
    computer_fire((cell[0].coordinate))
    cell[0].coordinate
  end

  def player_turn
    print "Enter the coordinate for your shot: "
    input = gets.chomp!.upcase
    until @computer.valid_coordinate?(input) && @computer.cells[input].fired_upon? == false
      puts "Please enter a valid coordinate: "
      input = gets.chomp!.upcase
    end
    @computer.cells[input].fire_upon
    if @computer.cells[input].ship == nil
      puts "Your shot on #{input} was a miss."
    elsif @computer.cells[input].ship != nil
      puts "Your shot on #{input} was a hit."
      if @computer.cells[input].ship.sunk?
        puts "You sunk my #{@computer.cells[input].ship.name}!"
      end
    end
  end

  def gameplay_loop
    computer_lose = @submarine_computer.sunk? && @cruiser_computer.sunk?
    player_lose = @submarine_player.sunk? && @cruiser_player.sunk?
    until computer_lose || player_lose
      2.times {puts "\n"}
      self.player_turn
      self.computer_picks_cell
      puts "\n"
      puts "=============COMPUTER BOARD============="
      print @computer.render
      puts "==============PLAYER BOARD=============="
      print @player.render(true)
      computer_lose = @submarine_computer.sunk? && @cruiser_computer.sunk?
      player_lose = @submarine_player.sunk? && @cruiser_player.sunk?
    end
    if computer_lose
      print "You won! \n"
    elsif player_lose
      print "I won! \n"
    end
  end


  def game_start
    puts "Welcome to BATTLESHIP!"
    puts "Enter p to play. Enter q to quit."
    input = gets.chomp!
    if input == "q"
      puts "Goodbye"
    elsif input == "p"
      computer_place(@submarine_computer)
      computer_place(@cruiser_computer)
      5.times { puts "\n"}
      puts "====================================="
      puts "I have laid out my ships on the grid."
      puts "You now need to lay out your two ships."
      puts "The Cruiser is three units long and the Submarine is two units long. "
      puts "Enter the squares for the Cruiser (3 spaces): "
      puts @player.render(true)
      player_cells = gets.chomp!.upcase.split
      until @player.valid_placement?(@cruiser_player, player_cells) do
        puts "\n Please enter valid coordinates: "
        player_cells = gets.chomp!.upcase.split
      end
      @player.place(@cruiser_player, player_cells)
      puts "\n==Cruiser placed=="
      puts "\n"
      puts @player.render(true)
      puts "Enter the squares for the Submarine (2 spaces): "
      player_cells = gets.chomp!.upcase.split
      until @player.valid_placement?(@submarine_player, player_cells) do
        puts "Please enter valid coordinates: "
        player_cells = gets.chomp!.upcase.split
      end
      @player.place(@submarine_player, player_cells)
      puts "\n==Submarine placed=="
      puts "\n"
      print @player.render(true)
      puts "\nLet's play!"
      gameplay_loop
    else
      p "Not a valid input"
      game_start
    end
  end

end
