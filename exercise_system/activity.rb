require_relative '../helpers/class_level_inheritable_attribute_list'

class Activity
  include ClassLevelInheritableAttributeList
  inheritable_attribute_list :distance, :altitude
  @altitude = 1000
  @distance = 8

  def call_private_method
    private_method
  end

  private

  def private_method
    puts "private"
  end
end