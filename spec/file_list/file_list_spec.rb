require_relative '../../file_list/file_list.rb'

RSpec.describe FileList, "#file_list" do

  context "with file list" do
    let(:expected_contents) { "Line 1\nLine 2\nLine 3" }

    it "file contents when retrieved using blocks is as expected" do
      contents = []
      FileList.open_and_process("file_list/testfile", "r") { |file| while line = file.gets; contents << line; end }
      expect(contents.join).to eq expected_contents
    end

    it "finds and counts words in file using Fiber as expected" do
      # TODO
      # expect (FileList.open_find_and_count_words("file_list/testfile")).to_not eq true
    end

    it "returns numbers not divisible by three using Fiber as expected" do
      numbers = FileList.numbers_not_divisible_by_three
      expect(numbers).to eq [2, 4, 8, 10, 14, 16, 20, 22, 26, 28]
    end

    it "performs coroutine using Fiber library extension as expected" do
      numbers = FileList.swap_between_producer_and_consumer
      expect(numbers).to eq [11, 12]
    end

  end
end