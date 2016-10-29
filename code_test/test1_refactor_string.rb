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

class Reformat
  attr_accessor :unformatted

  def initialize(unformatted); @unformatted = unformatted; end

  def reformat
    if @unformatted.length >= 2 && @unformatted.length <= 100
      removed_spaces = remove_all_spaces(@unformatted)
      extracted_integers = extract_integers(removed_spaces)
      grouped_in_threes_array = group_into_threes(extracted_integers)
      rearranged_last_two_groups = rearrange_last_two_groups(grouped_in_threes_array)
      applied_dashes = apply_dashes_between_groups(rearranged_last_two_groups)
      converted_array_to_string = convert_array_to_string(applied_dashes)
    else
      raise "Error: Input string S must have between 2 and 100 characters inclusive"
    end
  end

  private

  def remove_all_spaces(s); s.gsub(/\s+/, ""); end

  def extract_integers(s); s.gsub(/\D/, ''); end

  def group_into_threes(s); s.scan(/.{1,3}/); end

  def rearrange_last_two_groups(s)
    if s.last.length == 1
      # copy third char of second last element to the second char of last element
      last_elem = s[-1]
      last_elem = s[-2][2] + last_elem
      s[-2] = s[-2][0..1] # concat second last element to length two
      s[-1] = last_elem
    end
    s
  end

  def apply_dashes_between_groups(s)
    output = []
    s.each_with_index do |element, index|
      index != s.length - 1 ? output << element + "-" : output << element
    end
    output
  end

  def convert_array_to_string(s); s.join(""); end
end

# Warning: Do not change signature of this function!
def solution(s)
  # write your code in Ruby 2.2
  r = Reformat.new(s)
  r.reformat
end