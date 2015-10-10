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
  end

  context 'Object to hash' do
    before(:all) do
      @game = Game.new
      @killer = '#Killer'
      @killed = '#Killed'
      @cause  = '#Cause'

      @game.assignKill(@killer, @killed, @cause)
    end

    it 'should create the correct hash' do
      expected_hash = "{:total_kills=>#{@game.number_of_kills}, :players=>[\"#{@killer}\", \"#{@killed}\"], :kills=>{\"#{@killer}\"=>1, \"#{@killed}\"=>0}}"
      expect(@game.to_hash.to_s).to eq(expected_hash)
    end
  end
end
