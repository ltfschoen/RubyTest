require_relative '../../file_list/file_list.rb'

RSpec.describe FileList, "#file_list" do

  context "with file list" do
    let(:expected_contents) { "Line 1\nLine 2\nLine 3" }

    it "file contents when retrieved using blocks is as expected" do
      contents = []
      FileList.open_and_process("file_list/testfile", "r") { |file| while line = file.gets; contents << line; end }
      expect(contents.join).to eq expected_contents
    end
  end
end