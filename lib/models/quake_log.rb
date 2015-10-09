class QuakeLog
  attr_reader :players, :kills

  def initialize
    @players = Hash.new
    @kills   = Array.new
  end

  def assignKill(killer_name, killed_name, cause)
    killer = getPlayerStats(killer_name)
    killed = getPlayerStats(killed_name)

    killer.kills  = killer.kills  + 1
    killed.deaths = killed.deaths + 1
    @kills.push(KillEvent.new(killer, killed, cause))
  end

  def number_of_kills
    @kills.length
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
