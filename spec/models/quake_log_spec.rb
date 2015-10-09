require 'spec_helper'

describe QuakeLog do
  context 'create a new object' do
    it 'should start with no players or kills' do
      quake_log = QuakeLog.new
      expect(quake_log.number_of_kills).to eq(0)
    end
  end

  context 'Kill' do
    before(:each) do
      @quake_log = QuakeLog.new
      @killer_name = '#Killer'
      @killed_name = '#Killed'
      @cause       = '#Cause'
    end

    it 'should assign kill' do
      @quake_log.assignKill(@killer_name, @killed_name, @cause)
      expect(@quake_log.number_of_kills).to eq(1)
      expect(@quake_log.players.length ).to eq(2)

      kill = @quake_log.kills[0]
      expect(kill.killer.kills ).to eq(1)
      expect(kill.killed.deaths).to eq(1)
    end

    it 'should not duplicate players' do
      @quake_log.assignKill(@killer_name, @killed_name, @cause)
      @quake_log.assignKill(@killer_name, @killed_name, @cause)

      expect(@quake_log.number_of_kills).to eq(2)
      expect(@quake_log.players.length ).to eq(2)
    end
  end
end
