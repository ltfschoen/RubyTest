require 'deep_dive'
require_relative '../helpers/class_level_inheritable_attribute_list'

class Machine < Object
  include DeepDive
  exclude :manufacturer # exclude from deep cloning or duping instance variables with
                        # name @manufacturer whether defined in base class or subclasses.
                        # they will use the reference to the object instead (aka shallow copying)
  include ClassLevelInheritableAttributeList
  inheritable_attribute_list :name, :manufacturer, :show_manufacturer

  def initialize(name)
    @name = name
    @manufacturer = "luke schoen"
  end
end