class BoggleBoard
  def initialize
    @space = Array.new(16, "_")
  end

  def shake!
  end

  def to_s
    print @space
  end
end

puts BoggleBoard.new
