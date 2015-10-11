require 'spec_helper'

describe Game do
  context 'create a new object' do
    it 'should start with no players or kills' do
      game = Game.new
      expect(game.number_of_kills).to eq(0)
    end
  end

  context 'Kill' do
    before(:each) do
      @game = Game.new
      @killer_name = '#Killer'
      @killed_name = '#Killed'
      @cause       = '#Cause'
    end

    it 'should assign kill' do
      @game.assign_kill(@killer_name, @killed_name, @cause)
      expect(@game.number_of_kills).to eq(1)
      expect(@game.players.length ).to eq(2)

      kill = @game.kills[0]
      expect(kill.killer.kills ).to eq(1)
      expect(kill.killed.deaths).to eq(1)
    end

    it 'should not duplicate players' do
      @game.assign_kill(@killer_name, @killed_name, @cause)
      @game.assign_kill(@killer_name, @killed_name, @cause)

      expect(@game.number_of_kills).to eq(2)
      expect(@game.players.length ).to eq(2)
    end

    it 'should assign <world> kill, but not create kill entry' do
      @game.assign_kill(@killer_name, @killed_name, @cause) # Assign a player -> player kill
      @game.assign_kill('<world>'   , @killed_name, @cause) # Assign a world  -> player kill

      expect(@game.number_of_kills).to eq(2)
      expect(@game.players.length ).to eq(2) # Only "#Killer" and "#Killed", not "<world>"
    end

    it 'should discount a kill when killed by <world>' do
      # "@killer" killed "@killed" two times:
      # - @killer.kills = 2
      # - @killed.kills = 0
      @game.assign_kill(@killer_name, @killed_name, @cause)
      @game.assign_kill(@killer_name, @killed_name, @cause)

      # "<world>" killed each player once (should have their kills discounted):
      # - @killer.kills = 1
      # - @killed.kills = 0 (can't assign negative kills)
      @game.assign_kill('<world>', @killer_name, @cause)
      @game.assign_kill('<world>', @killed_name, @cause)

      expect(@game.number_of_kills).to eq(4)
      expect(@game.players[@killer_name].kills).to eq(1)
      expect(@game.players[@killed_name].kills).to eq(0)
    end
  end

  context 'Object to hash' do
    before(:all) do
      @game = Game.new
      @player1 = '#Player1'
      @player2 = '#Player2'
      @cause1 = '#Cause1'
      @cause2 = '#Cause2'
    end

    it 'should create the correct hash' do
      @game.assign_kill(@player1, @player2, @cause1) # Player1 killed Player2 by Cause1
      @game.assign_kill(@player1, @player2, @cause2) # Player1 killed Player2 by Cause2
      @game.assign_kill(@player2, @player1, @cause1) # Player2 killed Player1 by Cause1

      game_hash = @game.to_hash

      expect(game_hash[:total_kills]).to eq(@game.number_of_kills)

      # Should have 2 players: "#Killer" and "#Killed"
      expect(game_hash[:players].length).to eq(2)
      expect(game_hash[:players].include?(@player1)).to be true
      expect(game_hash[:players].include?(@player2)).to be true

      # Should generate a kill report for both players
      expect(game_hash[:kills].length).to eq(2)
      expect(game_hash[:kills][@player1]).to eq(@game.players[@player1].kills)
      expect(game_hash[:kills][@player2]).to eq(@game.players[@player2].kills)

      # Should generate kill by means report
      expect(game_hash[:kills_by_means].length).to eq(2)
      expect(game_hash[:kills_by_means][@cause1]).to eq(2) # Two kills by cause1
      expect(game_hash[:kills_by_means][@cause2]).to eq(1) # One kill by cause2
    end
  end
end
