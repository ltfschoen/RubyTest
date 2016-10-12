# Syntax:
#   - Class level variables denoted with @@
#   - Instance level variables denoted with @
#
# Problem Definition:
#   - No access to value of class-level variable when subclassing
#   - attr_accessor creates instance method getters/setters
#     for instances of class, not class itself
#   -
module ClassLevelInheritableAttributeList
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # Note:
    #   - Avoid variable naming clash with 'inheritable_attributes'
    #     when used as library in Rails project
    def inheritable_attribute_list(*args)
      @inheritable_attribute_list ||= [:inheritable_attribute_list]
      @inheritable_attribute_list += args
      args.each do |arg|
        class_eval %(
          class << self; attr_accessor :#{arg} end
        )
      end
      @inheritable_attribute_list
    end

    # Subclasses including this module are injected with class-level
    # instance variable for each declared and inheritable
    # class-level instance variables in the superclass (i.e. @inheritable_attribute_list)
    def inherited(subclass)
      @inheritable_attribute_list.each do |attribute|
        instance_var = "@#{attribute}"
        subclass.instance_variable_set(instance_var, instance_variable_get(instance_var))
      end
    end
  end
end