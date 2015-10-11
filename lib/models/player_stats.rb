#
# PLAYER STATS CLASS:
#
# Holds all information related to a single player progress in the game.
#
# CreatedBy: Mauricio Klein (mauricio.klein.msk@gmail.com)
# CreatedAt: Oct 10, 2015
#
class PlayerStats
  attr_accessor :deaths, :kills

  def initialize
    @deaths = 0
    @kills  = 0
  end
end
