require_relative 'Tile'

class Board

  CORRECT = Array(1..9)

  def initialize(grid)
    @grid = grid
  end

  def self.from_file(file)
    output = Array.new(9) { [] }
    array = File.readlines(file).map(&:chomp)
    array.each_with_index do |row, idx|
      row.chars.each_with_index do |tile|
        given = true
        tile.to_i.zero? ? given = false : given = true
        output[idx] << Tile.new(tile, given)
      end
    end
    Board.new(output)
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end

  def render
    @grid.each do |row|
      row.each do |tile|
        print tile.to_s.chomp + " "
      end
      puts "\n"
    end
  end

  def solved?
    correct_rows? && correct_cols? && all_boxes?
  end

  def correct_rows?
    @grid.each do |row|
      temp_array = []
      row.each do |tile|
        temp_array << tile.guess.to_i
      end
      return false unless temp_array.sort == CORRECT
    end
    true
  end

  def correct_cols?
    (0...9).each do |col|
      temp_array = []
      (0...9).each do |row|
        temp_array << @grid[col][row].guess.to_i
      end
      return false unless temp_array.sort == CORRECT
    end
    true
  end

  def correct_box?(row, col)
    temp_array = []
    (row...row + 3).each do |row_idx|
      (col...col + 3).each do |col_idx|
        temp_array << @grid[row_idx][col_idx].guess.to_i
      end
    end
    temp_array.sort == CORRECT
  end

  def all_boxes?
    row_idx = 0
    while row_idx < 7
      col_idx = 0
      while col_idx < 7
          return false unless correct_box?(row_idx, col_idx)
        col_idx += 3
      end
      row_idx += 3
    end
    true
  end

end
