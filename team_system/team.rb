class Team

  attr_reader :uid, :size

  def initialize(**data)
    # instance attribute cannot be id and assigned nil
    data.has_key?(:uid)
    is_valid(data[:uid])
    @uid = data.has_key?(:uid) && is_valid(data[:uid]) ? data[:uid] : self.object_id
    @size = data[:size]
  end

  private

  def self.all
    ObjectSpace.each_object(Team).to_a
  end

  def all
    Team.all
  end

  def has_instance_with_id(uid)
    a = all
    a.detect { |obj|
      if !obj.uid.nil?
        obj.uid == uid
      end
    }
  end

  def is_valid(uid)
    !uid.nil? && has_instance_with_id(uid).nil?
  end
end