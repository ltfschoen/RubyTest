module Debug

  # Module Instance Method
  def class_info?
    Debug.class_info?
  end

  # Class Method
  def self.class_info?
    "#{self.class.name}" # (id: #{self.object_id}): #{self.name}
  end
end