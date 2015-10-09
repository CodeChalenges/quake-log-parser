require 'spec_helper'

describe Parser do
  before(:all) do
    @parser = Parser.new
  end

  after(:each) do
    @parser.reset
  end

  context 'parse a single game with single kill' do
    it 'should process correctly' do
      # Should only create one game
      @parser.parse(File.expand_path(File.join(File.dirname(__FILE__), 'data/input_single_game_single_kill.txt')))
      expect(@parser.games.length).to eq(1)

      # Should create both players and the kill
      game = @parser.games[0]
      expect(game.players.length ).to eq(2)
      expect(game.number_of_kills).to eq(1)
    end
  end

  context 'parse a single game with multiple kills' do
    it 'should process correctly' do
      # Should only create one game
      @parser.parse(File.expand_path(File.join(File.dirname(__FILE__), 'data/input_single_game_multiple_kills.txt')))
      expect(@parser.games.length).to eq(1)

      # Should create both players and all kills
      game = @parser.games[0]
      expect(game.players.length ).to eq(3)
      expect(game.number_of_kills).to eq(3)
    end
  end

  context 'parse multiple games with single kill' do
    it 'should process correctly' do
      # Should create two games
      @parser.parse(File.expand_path(File.join(File.dirname(__FILE__), 'data/input_multiple_games_single_kill.txt')))
      expect(@parser.games.length).to eq(2)

      # Should create both players amd a single
      # kill per game
      game = @parser.games[0]
      expect(game.players.length ).to eq(2)
      expect(game.number_of_kills).to eq(1)

      game = @parser.games[1]
      expect(game.players.length ).to eq(2)
      expect(game.number_of_kills).to eq(1)
    end
  end

  context 'parse multiple games with multiple kills' do
    it 'should process correctly' do
      # Should create two games
      @parser.parse(File.expand_path(File.join(File.dirname(__FILE__), 'data/input_multiple_games_multiple_kills.txt')))
      expect(@parser.games.length).to eq(2)

      # Should create both players and 3 kills
      # per game
      game = @parser.games[0]
      expect(game.players.length ).to eq(3)
      expect(game.number_of_kills).to eq(3)

      game = @parser.games[1]
      expect(game.players.length ).to eq(3)
      expect(game.number_of_kills).to eq(3)
    end
  end

  context 'parse full game file' do
    it 'should process correctly' do
      @parser.parse(File.expand_path(File.join(File.dirname(__FILE__), 'data/input_full.txt')))
      expect(@parser.games.length).to eq(21)
    end
  end
end
