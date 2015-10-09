#
# Class to register a kill events
#
class KillEvent
  attr_reader :killer, :killed, :cause

  def initialize(killer, killed, cause)
    @killer = killer
    @killed = killed
    @cause  = cause
  end
end
