require 'spec_helper'

describe QuakeLog do
  context 'create a new object' do
    it 'should start with no players or kills' do
      quake_log = QuakeLog.new
      expect(quake_log.number_of_kills).to eq(0)
    end
  end

  context 'assign death' do
    before(:all) do
      @quake_log = QuakeLog.new
      @killer_name = '#Killer'
      @killed_name = '#Killed'
      @cause       = '#Cause'
    end

    it 'should assign kill' do
      @quake_log.assignKill(@killer_name, @killed_name, @cause)
      expect(@quake_log.number_of_kills).to eq(1)
      expect(@quake_log.kills[0].killer).to eq(@killer_name)
      expect(@quake_log.kills[0].killed).to eq(@killed_name)
      expect(@quake_log.kills[0].cause ).to eq(@cause)
    end
  end
end
