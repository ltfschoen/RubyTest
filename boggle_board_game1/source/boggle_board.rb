class BoggleBoard
  def initialize
    @space = Array.new(16, "_")
  end

  def shake!
  end

  def to_s
    # create a new variable and assign an empty string to store output
    output_string = String.new # equivalent to `output_string = ""`
    # store the instance variable containing the array in a temporary variable `letter_array`
    cols = rows = Math.sqrt(@space.length).to_i
    letter_array = @space
    # iterate over the array
    rows.times do
      output_string << letter_array.shift(4).join("") + "\n"
    end
    # last line of code in a Ruby method is returned
    output_string
  end
end

board = BoggleBoard.new
puts board.to_s
