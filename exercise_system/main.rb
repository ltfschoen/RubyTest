require_relative 'activity'
require_relative 'sport'

puts "Activity.class_variables: #{Activity.class_variables}" # => @@
puts "Activity.instance_variables: #{Activity.instance_variables}" # => @
puts "Activity.altitude: #{Activity.altitude}" # => 1000
puts "Activity.distance: #{Activity.distance}" # => 8
puts "Sport.altitude: #{Sport.altitude}" # => 500
puts "Sport.distance: #{Sport.distance}" # => 4
puts "Activity.new.call_private_method #{Activity.new.call_private_method}"