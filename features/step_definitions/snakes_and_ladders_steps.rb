Given /^a board with:$/ do |table|
  @board = Board.new
  table.hashes.each do |route|
    @board.add_route(route[:from].to_i, route[:to].to_i)
  end
end

Given /^I start a game with (\d+) players$/ do |number|
  @game = Game.start(@board, number.to_i)
end

def player(n)
  @game.players[n.to_i - 1]
end

Given /^player (\d+) rolls (\d+)$/ do |player_number, roll|
  @game.roll(roll.to_i)
end

Then /^player (\d+) is now on position (\d+)$/ do |player_number, position|
  player(player_number).position.should == position.to_i
end

Given /^player (\d+) is on position (\d+)$/ do |player_number, position|
  player(player_number).position = position.to_i
end

Then /^it is now player (\d+)'s go$/ do |player_number|
  @game.next_player.should == player(player_number)
end

Then /^player (\d+) has won the game$/ do |player_number|
  @game.winner.should == player(player_number)
end

