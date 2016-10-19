require_relative '../factories/team_factory'
require_relative '../../team_system/team'

RSpec.describe Team, "#team_system" do

  before(:all) do
    # Build Team instances and override properties
    @team1 = Team.new(uid: nil)
    @team2 = Team.new(uid: nil) # uid provided of nil is same as @team 1
    @team3 = Team.new(uid: 200)
    @team4 = Team.new(uid: 200) # same uid specified as parameter as for @team3

    # Build Team instances using FactoryGirl
    @team5 = build(:sample_team_without_uid)
    @team6 = build(:sample_team)
    @team6 << 10 << 20 << 30 << 40
    @team6[444, 555] = :super_team_name
  end

  context "with new team being created" do
    it "does not create duplicate of existing uid when provided uid is nil" do
      expect(@team2.uid).to_not eq @team1.uid
      expect(@team5.uid).to_not eq @team2.uid
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

    it "updates count of amount of times the performance rating was updated for the team" do
      expect(@team6.rating_change_count).to eq 4
    end

    it "calculates average performance of team" do
      expect(@team6.rating_average).to eq 25
    end
  end

  context "with team" do
    let(:expected_team_groups) { {:super_team_name => [444, 555] } }

    it "stores team ids and team name in team hash" do
      expect(@team6.team_groups).to eq expected_team_groups
    end
  end
end