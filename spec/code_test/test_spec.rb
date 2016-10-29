require_relative '../../code_test/test1_refactor_string'

RSpec.describe Reformat, "#test" do

  before(:each) do
    @s1 = "00-44  48 5555 8361" # expected result "004-448-555-583-61"
    @s2 = "0 - 22 1985--324" # expected result "022-198-53-24"
    @s3 = "555372654" # expected result "555-372-654"
    @s4 = "1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111"
    # edge cases
    @s5 = "11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111119"
    @s6 = "1"
  end

  context "with sample unformatted strings" do

    it "reformats string sample 1 into expected result" do
      expect(solution(@s1)).to eq "004-448-555-583-61"
    end

    it "reformats string sample 2 into expected result" do
      expect(solution(@s2)).to eq "022-198-53-24"
    end

    it "reformats string sample 3 into expected result" do
      expect(solution(@s3)).to eq "555-372-654"
    end

    it "reformats string sample 4 into expected result" do
      expect(solution(@s4)).to eq "111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-111-11-11"
    end

    it "raises runtime error when input >= 100 characters" do
      expect{ solution(@s5) }.to raise_error(RuntimeError)
    end

    it "raises runtime error when input <= 2 characters" do
      expect{ solution(@s6) }.to raise_error(RuntimeError)
    end
  end
end



# Given string `S` passed as argument to `solutions` function contains:
# - N chars
#   - string `S` comprising >= 2 digits, only of digits 0-9 inclusive, spaces and/or dashes
#   - Ignore spaces and dashes
#   - where N is an Integer type in range 2..100 (i.e. 2 to 100 inclusive)
#
# Expectations:
# - Output
#   - Reformat string `S` so:
#     - digits grouped in blocks of length 3, separated by single dashes
#     - remove all spaces
#     - last and/or second last block may be of length 2
#     - e.g. 1  (i.e. `00-44  48 5555 8361` --> `004-448-555-583-61`)
#     - e.g. 2 (i.e. `0 - 22 1985--324` --> `022-198-53-24`)
#     - e.g. 3 (i.e. `555372654` --> `555-372-654`)
# - Compiler - Ruby 2.2 (i.e. rvm use 2.2.0)
# - Correctness is the focus (i.e. unit test)