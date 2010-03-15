class Player

  def self.create(n, board)
    (1..n).map { |n| Player.new(board) }
  end

  attr_accessor :position

  def initialize(board = nil)
    @position = 0
    @board = board
  end

  def roll(n)
    @position += n
    @position = @board.position(@position) if @board
  end
end


