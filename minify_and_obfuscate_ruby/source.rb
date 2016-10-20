require 'bigdecimal'

class Obfiscate
	include Comparable

  attr_reader :name

  def initialize(name)
  	@name = name
  end
end