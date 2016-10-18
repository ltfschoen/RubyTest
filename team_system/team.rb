class Team

  attr_reader :uid, :size, :rating_total, :rating_count

  def initialize(**data)
    # instance attribute cannot be id and assigned nil
    data.has_key?(:uid)
    is_valid(data[:uid])
    @uid = data.has_key?(:uid) && is_valid(data[:uid]) ? data[:uid] : self.object_id
    @size = data[:size]
    @rating_total = @rating_count = 0
  end

  public

  def <<(new_rating)
    @rating_total += new_rating
    @rating_count += 1
    self
  end

  def rating_average
    fail "No ratings" if @rating_count.zero?
    Float(@rating_total) / @rating_count
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

# team1 = Team.new(uid: nil, size: 100)
# team2 = Team.new(uid: nil, size: 200)
# team3 = Team.new(uid: 200, size: 300)
# team4 = Team.new(uid: 200, size: 400)
# team5 = Team.new(size: 500)
team6 = Team.new(uid: 100, size: 200)
team6 << 10 << 20 << 30 << 40