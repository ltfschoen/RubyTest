require_relative '../helpers/class_level_inheritable_attribute_list'

class Machine < Object
  include ClassLevelInheritableAttributeList
  inheritable_attribute_list :name, :manufacturer, :show_manufacturer

  def initialize(name)
    @name = name
    @manufacturer = "luke schoen"
  end
end