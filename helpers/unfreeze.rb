# http://stackoverflow.com/questions/35633367/how-to-unfreeze-an-object-in-ruby

require 'fiddle'

class Object
  # unfreeze and object
  def unfreeze; Fiddle::Pointer.new(object_id * 2)[1] &= ~(1 << 3); end
end