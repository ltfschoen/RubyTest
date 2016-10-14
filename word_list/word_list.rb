class WordList

  # Define default Getter methods, but not Setter methods
  attr_reader :word_list, :count_frequency

  # Delegate to Setter methods instead of set instance variables directly.
  def initialize(word_list)
    self.word_list = word_list
    self.count_frequency = word_list
  end

  private

  # Setter method enforces rules
  def word_list=(word_list)
    @word_list = word_list
  end

  def count_frequency=(word_list)
    counts = Hash.new(0)
    for word in word_list
      counts[word] += 1
    end
    @count_frequency = counts
  end
end