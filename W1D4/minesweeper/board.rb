require_relative 'tile'

class Board

  attr_reader :grid

  def intialize(size, num_bombs)
    @grid = Array.new(size) { Array.new(size) }
    populate(num_bombs)
  end

  def populate(number)
    @grid.each do |row|
      row.each do |col|
        @grid[row][col] = Tile.new
      end
    end
    seed_bombs(number)
    @grid.each do |row|
      row.each do |col|
        calc_adjacencies([row, col])
      end
    end
  end

  def seed_bombs(number)
    until number == 0
      pos = rand_pos
      unless @grid[pos].value == :bomb
        @grid[pos].value = :bomb
        number -= 1
      end
    end
  end

  def calc_adjacencies(pos)
    x, y = pos
    neighbors = []
    bomb_count = 0
    (x-1..x+1).each do |x|
      (y-1..y+1).each do |y|
        neighbors << @grid[x][y].value if valid_pos?([x, y]) && [x, y] != pos
      end
    end
    neighbors.each { |neighbor| bomb_count +=1 if neighbor == :bomb }
    @grid[pos].adj_bombs = bomb_count
  end

  def rand_pos
    [rand(grid.size), rand(grid.size)]
  end

  def valid_pos?(pos)
    !@grid[pos].nil?
  end

  def won?
  end

  alias_method :rows, :grid

  def columns
    rows.transpose!
  end

  def diagonals_up

  end

  def diagonals_down
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[pos].value = value
  end
end
