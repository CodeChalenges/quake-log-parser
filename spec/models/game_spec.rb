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
      @game.assignKill(@killer_name, @killed_name, @cause)
      expect(@game.number_of_kills).to eq(1)
      expect(@game.players.length ).to eq(2)

      kill = @game.kills[0]
      expect(kill.killer.kills ).to eq(1)
      expect(kill.killed.deaths).to eq(1)
    end

    it 'should not duplicate players' do
      @game.assignKill(@killer_name, @killed_name, @cause)
      @game.assignKill(@killer_name, @killed_name, @cause)

      expect(@game.number_of_kills).to eq(2)
      expect(@game.players.length ).to eq(2)
    end

    it 'should assign <world> kill, but not create kill entry' do
      @game.assignKill(@killer_name, @killed_name, @cause) # Assign a player -> player kill
      @game.assignKill('<world>'   , @killed_name, @cause) # Assign a world  -> player kill

      expect(@game.number_of_kills).to eq(2)
      expect(@game.players.length ).to eq(2) # Only "#Killer" and "#Killed", not "<world>"
    end
  end

  context 'Object to hash' do
    before(:all) do
      @game = Game.new
      @killer_name = '#Killer'
      @killed_name = '#Killed'
      @cause  = '#Cause'

      @game.assignKill(@killer_name, @killed_name, @cause)
    end

    it 'should create the correct hash' do
      game_hash = @game.to_hash

      expect(game_hash[:total_kills]).to eq(@game.number_of_kills)

      # Should have 2 players: "#Killer" and "#Killed"
      expect(game_hash[:players].length).to eq(2)
      expect(game_hash[:players].include?(@killer_name)).to be true
      expect(game_hash[:players].include?(@killed_name)).to be true

      # Should generate a kill report for both players
      expect(game_hash[:kills].length).to eq(2)
      expect(game_hash[:kills][@killer_name]).to eq(@game.players[@killer_name].kills)
      expect(game_hash[:kills][@killed_name]).to eq(@game.players[@killed_name].kills)
    end
  end
end
