class Game

  def self.start(board, number_of_players)
    new(*Player.create(number_of_players, board))
  end
  
  attr_reader :players

  def initialize(*players)
    @players = players
    @current_player_index = 0
  end

  def next_player
    @players[@current_player_index]
  end

  def roll(n)
    next_player.roll(n)
    complete_turn(n)
  end

  def winner
    @players.find { |player| player.position == 100 }
  end

  private
  def self.create_players(n, board)
    Player.create(n, board)
  end

  def complete_turn(n)
    @current_player_index += 1 unless n == 6
    @current_player_index = 0 if @current_player_index >= @players.size
  end
end

