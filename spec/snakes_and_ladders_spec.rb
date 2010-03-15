require 'spec_helper'

describe "basic movement" do

  before(:each) do
    @player = Player.new
  end

  context "when the player is at the start" do
    it "will move to position 1 when they roll 1" do
      @player.roll(1)
      @player.position.should == 1
    end

    it "will move to position 2 when they roll 2" do
      @player.roll(2)
      @player.position.should == 2
    end
  end

  context "when the player starts at position 50" do
    it "will move to position 53 when the roll 3" do
      @player.position = 50
      @player.roll(3)
      @player.position.should == 53
    end
  end
  context "with routes" do
    it "moves to the end of the ladder when landing on the start" do
      board = mock(:board)
      board.stub!(:position).with(5).and_return(10)
      player = Player.new(board)
      player.roll(5)
      player.position.should == 10
    end 
  end
end

describe "routing" do
  it "returns the position when there's no special routing" do
    board = Board.new
    board.position(1).should == 1
    board.position(15).should == 15
  end

  it "returns the end of the route when passed the start" do
    board = Board.new
    board.add_route(5, 10)
    board.add_route(99, 2)
    board.position(5).should == 10
    board.position(99).should == 2
    board.position(1).should == 1
  end

  it "moves backwards after position 100" do
    board = Board.new
    board.position(101).should == 99
    board.position(103).should == 97
  end
end

describe "taking next_players" do
  context "with one player" do
    it "is always player 1s next_player" do
      player1 = mock(:player1, :roll => nil)
      game = Game.new(player1)
      game.next_player.should == player1
      game.roll(1)
      game.next_player.should == player1
      game.roll(3)
      game.next_player.should == player1
    end
  end
  context "with two players" do
    before(:each) do
      @player1, @player2 = mock(:player1, :roll => nil), mock(:player2, :roll => nil)
      @game = Game.new(@player1, @player2)
    end

    it "is player 1s next_player at the start" do
      @game.next_player.should == @player1
    end
    
    it "is player 2s next_player after the first roll between 1-5" do
      @game.roll(1)
      @game.next_player.should == @player2
    end

    it "is alternate players next_players after the first roll between 1-5" do
      @game.roll(1)
      @game.next_player.should == @player2
      @game.roll(2)
      @game.next_player.should == @player1
      @game.roll(5)
      @game.next_player.should == @player2
    end
    
    it "is player 2s next_player again after throwing a 6" do
      @game.roll(1)
      @game.roll(6)
      @game.next_player.should == @player2
    end
    
    it "assigns the roll to the correct player" do
      5.times do |n|
        n += 1
        p = @game.next_player
        p.should_receive(:roll).with(n)
        @game.roll(n)
      end
    end
  end
  
  describe "winning" do
    it "returns the player who is on position 100" do
      player = mock(:player, :position => 100)
      game = Game.new(mock(:player, :position => 50), player)
      game.winner.should == player
    end

    it "returns no winner when no winner is on 100" do
      game = Game.new(mock(:player, :position => 50), mock(:player, :position => 25))
      game.winner.should be_nil
    end
  end
end
