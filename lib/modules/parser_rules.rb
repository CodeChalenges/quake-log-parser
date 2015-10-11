#
# PARSER RULES MODULE:
#
# A helper module with string regex rules used in log parser process.
#
# CreatedBy: Mauricio Klein (mauricio.klein.msk@gmail.com)
# CreatedAt: Oct 10, 2015
#

module ParserRules
  # Regex to detect the begining of a new game
  def self.InitGame
    /InitGame/
  end

  # Regex to detect a kill occurence in the current game
  def self.Kill
    /:\s([^:]+)\skilled\s(.*?)\sby\s[a-zA-Z_]+/
  end

  # Usefull regex, used in conjunction with 'split' method,
  # to retrieve kill informations from a log entry
  def self.KillSplit
    Regexp.union(/killed/,/by/)
  end
end
