require 'models/game'
require 'modules/parser_rules'
require 'version'

#
# QUAKE LOG PARSER CLASS:
#
# Top level class, responsable to parse log file and control
# all metrics
#
# CreatedBy: Mauricio Klein (mauricio.klein.msk@gmail.com)
# CreatedAt: Oct 10, 2015
#
class Quake
  attr_reader :games

  def initialize
    @current_game = nil
    @games = []
  end

  def parse(filepath)
    file = File.new(filepath)

    while (line = file.gets)
      process_line(line)
    end

    true
  rescue => err
    puts "Failed to read log file: #{err}"
    err
  end

  def reset
    @current_game = nil
    @games.clear
  end

  def self.version
    QuakeVersion::VERSION
  end

  private

  def process_line(line)
    if line =~ ParserRules.init_game
      @current_game = Game.new
      @games.push(@current_game)
    elsif line =~ ParserRules.kill
      parse_kill_line(line)
    end
  end

  def parse_kill_line(line)
    kill_line = line.split(':').last
    kill_info = kill_line.split(ParserRules.kill_split)

    killer = kill_info[0].strip
    killed = kill_info[1].strip
    cause  = kill_info[2].strip
    @current_game.assign_kill(killer, killed, cause)
  end
end
