require 'colorize'
require 'colorized_string'

class Tile
  attr_reader :guess, :given

  def initialize(num, given = false)
    @given = given
    @guess = num
  end

  def to_s
    @given ? color = :blue : color = :black
    @guess.to_s.colorize(color)
  end
end
