class QuakeLog
  attr_reader :kills

  def initialize
    @kills = Array.new
  end

  def assignKill(killer, killed, cause)
    @kills.push(KillEvent.new(killer, killed, cause))
  end

  def number_of_kills
    @kills.length
  end
end
