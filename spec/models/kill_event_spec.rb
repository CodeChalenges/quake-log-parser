require 'spec_helper'

describe KillEvent do
  context 'create a new object' do
    it 'should store data correctly' do
      kill = KillEvent.new('#Killer', '#Killed', '#Cause')
      expect(kill.killer).to eq('#Killer')
      expect(kill.killed).to eq('#Killed')
      expect(kill.cause).to eq('#Cause')
    end
  end
end
