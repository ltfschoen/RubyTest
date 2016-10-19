require_relative '../../team_system/team'

# This will guess the User class
FactoryGirl.define do
  # Explicitly use Team class
  factory :sample_team, class: Team do
    # Serialise hash attribute: http://www.rubycoloredglasses.com/2012/06/add-a-serialized-hash-attribute-to-a-factory_girl-definition/
    sequence :uid do |n| n end
    size {rand(1..100)}
    rating_total 0
    rating_change_count 0
    team_groups { { super_team_name: [444, 555]} }
  end

  factory :sample_team_without_uid, class: Team do; end
end