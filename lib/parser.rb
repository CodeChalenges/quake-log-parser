require "version"
require "modules/parser_rules"

class Parser
  attr_reader :games

  def initialize
    @current_game = nil
    @games = Array.new
  end

  def parse(filepath)
    begin
      file = File.new(filepath)

      while(line = file.gets)
        if line =~ ParserRules.InitGame
          @current_game = Game.new
          @games.push(@current_game)
        elsif line =~ ParserRules.Kill
          parseKillLine(line)
        end
      end
    rescue => err
      puts "Failed to read log file:  #{err}"
      err
    end
  end

  def reset
    @current_game = nil
    @games.clear
  end

  private
    def parseKillLine(line)
      kill_line = line.split(':').last
      kill_info = kill_line.split(Regexp.union(/killed/,/by/))

      killer = kill_info[0].strip
      killed = kill_info[1].strip
      cause  = kill_info[2].strip
      @current_game.assignKill(killer, killed, cause)
    end
end
