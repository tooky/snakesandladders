class Board
  WINNING_POSITION = 100
  def initialize
    @routes = Hash.new do |routes, position|
      past_winning_post(position) ? move_back_from_winning_post(position) : position
    end
  end

  def add_route(from, to)
    @routes[from] = to
  end

  def position(n)
    @routes[n]
  end

  private
  def past_winning_post(position)
    position > WINNING_POSITION
  end

  def move_back_from_winning_post(position)
    WINNING_POSITION - (position - WINNING_POSITION)
  end
end
