require_relative '../../mixins/debug.rb'

class TestClass
  include Debug

  # Override Module superclass Instance Method
  def class_info?; "#{self.class.name}" end
end

RSpec.describe Debug, "#class_info?" do
  include Debug

  let(:test_instance) { TestClass.new }

  before(:each) do
    @class_info_instance_method = Debug.instance_methods[0].to_s
    @class_info = Debug.class_info?
  end

  context "with mixins" do
    it "has class info instance method" do
      expect(@class_info_instance_method).to eq "class_info?"
    end

    it "shows class info for the Module itself" do
      expect(@class_info).to eq "Module"
    end

    it "shows class info for Classes that include the Module" do
      expect(test_instance.class_info?).to eq "TestClass"
    end
  end
end