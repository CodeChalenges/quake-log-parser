#
# QUAKE LOG PARSER CLASS:
#
# Top level class, responsable to parse log file and control
# all metrics
#
# CreatedBy: Mauricio Klein (mauricio.klein.msk@gmail.com)
# CreatedAt: Oct 10, 2015
#

require 'models/game'
require 'modules/parser_rules'
require 'version'

class Quake
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
      puts "Failed to read log file: #{err}"
      err
    end
  end

  def reset
    @current_game = nil
    @games.clear
  end

  def self.version
    QuakeVersion::VERSION
  end

  private
    def parseKillLine(line)
      kill_line = line.split(':').last
      kill_info = kill_line.split(ParserRules.KillSplit)

      killer = kill_info[0].strip
      killed = kill_info[1].strip
      cause  = kill_info[2].strip
      @current_game.assignKill(killer, killed, cause)
    end
end
