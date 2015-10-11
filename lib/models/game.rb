require 'hmap'
require 'models/kill_event'
require 'models/player_stats'

#
# GAME CLASS:
#
# Holds all information related to a single game.
#
# CreatedBy: Mauricio Klein (mauricio.klein.msk@gmail.com)
# CreatedAt: Oct 10, 2015
#
class Game
  attr_reader :players, :kills

  def initialize
    @players = {}
    @kills   = []
    @nkills  = 0
  end

  #
  # Assign a new game kill
  #
  def assign_kill(killer_name, killed_name, cause)
    # Assign a new death to killed player
    killed = get_player_stats(killed_name)
    killed.deaths += 1

    if killer_name.eql?('<world>')
      # If killed by <world>, killed player looses 1 kill
      killed.kills -= 1 if killed.kills > 0
    else
      # Assign a kill to killer player
      killer = get_player_stats(killer_name)
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
      kills: @players.hmap do |name, stats|
        { name => stats.kills }
      end,
      kills_by_means: kill_by_means_hash
    }
  end

  private

  #
  # If a player stats object already exists, returns it.
  # Otherwise, creates a new one
  #
  def get_player_stats(player_name)
    @players[player_name] = PlayerStats.new unless @players.key?(player_name)
    @players[player_name]
  end

  #
  # Create a hash of game kills,
  # grouped by mean
  #
  def kill_by_means_hash
    kills_hash = {}

    @kills.map do |kill|
      accumulated = kills_hash.key?(kill.cause) ? kills_hash[kill.cause] : 0
      kills_hash[kill.cause] = accumulated + 1
    end

    kills_hash
  end
end
