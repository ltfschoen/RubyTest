require_relative '../../mixins/debug.rb'

RSpec.describe Debug, "#class_info?" do
  include Debug

  before(:each) do
    @class_info_instance_method = Debug.instance_methods[0].to_s
    @class_info = Debug.class_info?
  end

  context "with mixins" do
    it "has class info instance method" do
      expect(@class_info_instance_method).to eq "class_info?"
    end

    it "shows class info" do
      expect(@class_info).to eq "Module"
    end
  end
end