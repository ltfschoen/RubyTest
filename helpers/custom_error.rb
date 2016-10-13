class CustomError < StandardError
  attr_reader :custom

  def initialize(custom)
  	super
    @custom = custom
  end
end