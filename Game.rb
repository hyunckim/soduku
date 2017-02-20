require_relative 'Board'

class Game
  def initialize(board)
    @board = board
  end

  def play
    until @board.solved?
      @board.render
      prompt
    end
    puts "You Win"
  end

  def prompt
    puts "Enter the position"
    input = gets.chomp
    pos =[]
    input.scan(/\d+/) {|digit| pos << digit.to_i}

    puts "Enter the value"
    input = gets.chomp.to_i

    @board[pos] = Tile.new(input)
  end

end

g = Game.new(Board.from_file('sudoku1-solved.txt'))
g.play
