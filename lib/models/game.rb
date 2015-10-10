require 'hmap'

class Game
  attr_reader :players, :kills

  def initialize
    @players = Hash.new
    @kills   = Array.new
    @nkills  = 0
  end

  def assignKill(killer_name, killed_name, cause)
    # Assign a new death to killed player
    killed = getPlayerStats(killed_name)
    killed.deaths += 1

    if killer_name.eql?('<world>')
      # If killed by <world>, killed player looses 1 kill
      killed.kills -= 1
    else
      # Assign a kill to killer player
      killer = getPlayerStats(killer_name)
      killer.kills += 1

      # Add a new kill entry on dictionary
      @kills.push(KillEvent.new(killer, killed, cause))
    end

    # Increment game kills counter
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
      }
    }
  end

  private
    def getPlayerStats(player_name)
      # If the player doesn't exist yet, create a new stats holder
      unless @players.has_key?(player_name)
        @players[player_name] = PlayerStats.new
      end

      @players[player_name]
    end
end
