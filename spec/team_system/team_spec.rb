require_relative '../../team_system/team'

RSpec.describe Team, "#team_system" do

  before(:each) do
    @team1 = Team.new(uid: nil, size: 100)
    @team2 = Team.new(uid: nil, size: 200)
    @team3 = Team.new(uid: 200, size: 300)
    @team4 = Team.new(uid: 200, size: 400)
    @team5 = Team.new(size: 500)
    @team6 = Team.new(uid: nil, size: 100)
    @team6 << 10 << 20 << 30 << 40
  end

  context "with new team being created" do
    it "does not create duplicate of existing uid when provided uid is nil" do
      expect(@team1.uid).to_not eq @team2.uid
      expect(@team1.uid).to_not eq @team5.uid
    end

    it "does not create duplicate of existing uid when provided uid is same as an existing uid" do
      expect(@team3.uid).to_not eq @team4.uid
    end

    it "creates unique uid based on the instances object_id when no uid argument is provided to initialiser" do
      expect(@team5.instance_variable_defined?(:@uid)).to eq true
      expect(@team5.uid).to eq @team5.object_id
    end
  end

  context "with team and performance rating added" do
    it "updates performance rating for team" do
      expect(@team6.rating_total).to eq 100
    end

    it "calculates average performance of team" do
      expect(@team6.rating_average).to eq 25
    end
  end
end