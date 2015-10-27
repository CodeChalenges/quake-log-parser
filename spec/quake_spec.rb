require 'spec_helper'

describe Quake do
  before(:all) do
    @parser = Quake.new
  end

  after(:each) do
    @parser.reset
  end

  context 'informations' do
    it 'should inform the correct parser version' do
      expect(Quake.version).to eq(QuakeVersion::VERSION)
    end
  end

  context 'parse a single game with single kill' do
    it 'should process correctly' do
      # Should only create one game
      @parser.parse(File.expand_path(File.join(File.dirname(__FILE__), 'data/single_game_single_kill.txt')))
      expect(@parser.games.length).to eq(1)

      # Should create both players and the kill
      game = @parser.games[0]
      expect(game.players.length ).to eq(1) # Player "<world>" shouldn't be counter
      expect(game.number_of_kills).to eq(1)
    end
  end

  context 'parse a single game with multiple kills' do
    it 'should process correctly' do
      # Should only create one game
      @parser.parse(File.expand_path(File.join(File.dirname(__FILE__), 'data/single_game_multiple_kills.txt')))
      expect(@parser.games.length).to eq(1)

      # Should create both players and all kills
      game = @parser.games[0]
      expect(game.players.length ).to eq(2) # Player "<world>" shouldn't be counter
      expect(game.number_of_kills).to eq(3)
    end
  end

  context 'parse multiple games with single kill' do
    it 'should process correctly' do
      # Should create two games
      @parser.parse(File.expand_path(File.join(File.dirname(__FILE__), 'data/multiple_games_single_kill.txt')))
      expect(@parser.games.length).to eq(2)

      # Should create both players amd a single
      # kill per game
      game = @parser.games[0]
      expect(game.players.length ).to eq(1) # Player "<world>" shouldn't be counter
      expect(game.number_of_kills).to eq(1)

      game = @parser.games[1]
      expect(game.players.length ).to eq(2)
      expect(game.number_of_kills).to eq(1)
    end
  end

  context 'parse multiple games with multiple kills' do
    it 'should process correctly' do
      # Should create two games
      @parser.parse(File.expand_path(File.join(File.dirname(__FILE__), 'data/multiple_games_multiple_kills.txt')))
      expect(@parser.games.length).to eq(2)

      # Should create both players and 3 kills
      # per game
      game = @parser.games[0]
      expect(game.players.length ).to eq(2) # Player "<world>" shouldn't be counter
      expect(game.number_of_kills).to eq(3)

      game = @parser.games[1]
      expect(game.players.length ).to eq(3)
      expect(game.number_of_kills).to eq(3)
    end
  end

  context 'parse log file with many games' do
    it 'should process correctly' do
      @parser.parse(File.expand_path(File.join(File.dirname(__FILE__), 'data/full_match.txt')))
      expect(@parser.games.length).to eq(21)
    end
  end

  context 'parse a second log file' do
    it 'should cleanup structure before parsing' do
      @parser.parse(File.expand_path(File.join(File.dirname(__FILE__), 'data/full_match.txt')))
      ngames = @parser.games.length

      # Parse the file again: should cleanup the structure before parsing again
      @parser.parse(File.expand_path(File.join(File.dirname(__FILE__), 'data/full_match.txt')))

      expect(@parser.games.length).to eq(ngames)
    end
  end

  context 'parse an unknown file' do
    it 'should return an error' do
      expect{@parser.parse('')}.to raise_error(Errno::ENOENT)
    end
  end
end
