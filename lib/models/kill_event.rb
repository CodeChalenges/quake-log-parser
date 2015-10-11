#
# KILL EVENT CLASS:
#
# Holds all information related to a single game kill.
#
# CreatedBy: Mauricio Klein (mauricio.klein.msk@gmail.com)
# CreatedAt: Oct 10, 2015
#
class KillEvent
  attr_reader :killer, :killed, :cause

  def initialize(killer, killed, cause)
    @killer = killer
    @killed = killed
    @cause  = cause
  end
end
