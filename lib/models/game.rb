#
# GAME CLASS:
#
# Holds all information related to a single game.
#
# CreatedBy: Mauricio Klein (mauricio.klein.msk@gmail.com)
# CreatedAt: Oct 10, 2015
#

require 'hmap'
require 'models/kill_event'
require 'models/player_stats'

class Game
  attr_reader :players, :kills

  def initialize
    @players = Hash.new
    @kills   = Array.new
    @nkills  = 0
  end

  #
  # Assign a new game kill
  #
  def assignKill(killer_name, killed_name, cause)
    # Assign a new death to killed player
    killed = getPlayerStats(killed_name)
    killed.deaths += 1

    if killer_name.eql?('<world>')
      # If killed by <world>, killed player looses 1 kill
      killed.kills -= 1 if killed.kills > 0
    else
      # Assign a kill to killer player
      killer = getPlayerStats(killer_name)
      killer.kills += 1

      # Add a new kill entry on dictionary
      @kills.push(KillEvent.new(killer, killed, cause))
    end

    @nkills += 1
  end

  def number_of_kills
    @nkills
  end

  def to_hash
    {
      total_kills: @nkills,
      players: @players.keys,
      kills: @players.hmap { |name, stats|
        { name => stats.kills }
      },
      kills_by_means: killByMeansHash
    }
  end

  private
    #
    # If a player stats object already exists, returns it.
    # Otherwise, creates a new one
    #
    def getPlayerStats(player_name)
      unless @players.has_key?(player_name)
        @players[player_name] = PlayerStats.new
      end

      @players[player_name]
    end

    #
    # Create a hash of game kills,
    # grouped by mean
    #
    def killByMeansHash
      killByMeansHash = Hash.new

      @kills.map { |kill|
        accumulated = killByMeansHash.has_key?(kill.cause) ? killByMeansHash[kill.cause] : 0
        killByMeansHash[kill.cause] = accumulated + 1
      }

      killByMeansHash
    end
end
