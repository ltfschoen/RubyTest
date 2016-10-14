require_relative '../../word_list/word_list.rb'
require_relative '../../helpers/words_from_string.rb'

RSpec.describe WordList, "#count_frequency" do

  before(:each) do
    raw_text = %{Array of multiple string values from string of words.}
    word_list = words_from_string(raw_text)
    @word_list = WordList.new(word_list)
  end

  context "with word list" do
    let(:expected_frequency_count) { {"array"=>1, "of"=>2, "multiple"=>1, "string"=>2, "values"=>1, "from"=>1, "words"=>1} }
    let(:expected_top_three) { [["of", 2], ["string", 2], ["values", 1]] }

    it "counts frequency of duplicate words correctly" do
      expect(@word_list.count_frequency).to eq expected_frequency_count
    end

    it "returns top 3 frequency counts in descending order" do
      expect(@word_list.top_three).to eq expected_top_three
    end
  end
end