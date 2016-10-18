class Team

  attr_reader :uid, :size, :rating_total, :rating_change_count, :team_groups

  def initialize(**data)
    # instance attribute cannot be id and assigned nil
    self.uid = data.has_key?(:uid) && is_valid(data[:uid]) ? data[:uid] : self.object_id
    self.size = data[:size]
    self.team_groups = Hash.new(0)
    self.rating_total = self.rating_change_count = 0
  end

  public

  def uid=(uid); @uid = uid end
  def size=(size); @size = size end
  def team_groups=(team_groups); @team_groups = team_groups end
  def rating_total=(rating_total); @rating_total = rating_total end
  def rating_change_count=(rating_change_count); @rating_change_count = rating_change_count end

  def <<(new_rating)
    @rating_total += new_rating
    @rating_change_count += 1
    self # allow method chaining
  end

  def rating_average
    fail "No ratings" if @rating_change_count.zero?
    Float(@rating_total) / @rating_change_count
  end

  # params are team ids to assign to team name stored in last element
  def []=(*params); @team_groups[params.pop.to_sym] = params end

  private

  def self.all; ObjectSpace.each_object(Team).to_a end

  def all; Team.all end

  def has_instance_with_id(uid)
    all.detect { |obj| if !obj.uid.nil?; obj.uid == uid end }
  end

  def is_valid(uid); !uid.nil? && has_instance_with_id(uid).nil? end
end

# team1 = Team.new(uid: nil, size: 100)
# team2 = Team.new(uid: nil, size: 200)
# team3 = Team.new(uid: 200, size: 300)
# team4 = Team.new(uid: 200, size: 400)
# team5 = Team.new(size: 500)
# team6 = Team.new(uid: 100, size: 200)
# team6 << 10 << 20 << 30 << 40
# team6['444', '555'] = :super_team_name