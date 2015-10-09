module ParserRules
  def self.InitGame
    /InitGame/
  end

  def self.EndGame
    /ShutdownGame/
  end

  def self.Kill
    /:\s([^:]+)\skilled\s(.*?)\sby\s[a-zA-Z_]+/
  end
end
