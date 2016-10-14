module Debug
  def class_info?
    "#{self.class.name}"# (id: #{self.object_id})"
  end
end