require_relative 'machine.rb'

class Robot < Machine
  attr_accessor :name, :name_count, :obj_count, :manufacturer

  # Delegate to Setter methods instead of set instance variables directly.
  def initialize(name); super; self.name = name; @name_count = name.length; @obj_count = Robot.count; end;

  # Setter method enforces rules
  def name=(name); @name = name; end

  # Call with `puts <class_instance_name>`
  def to_s; "name: #{@name}"; end

  def get_input; input = gets.chomp; puts input; end

  def show_manufacturer; @manufacturer; end

  # Quantity of Class Instance Objects
  def self.all; ObjectSpace.each_object(self).to_a end

  def self.count; all.length end

end