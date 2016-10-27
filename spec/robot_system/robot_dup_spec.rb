require_relative '../../robot_system/robot.rb'
require_relative '../../helpers/utility.rb'

RSpec.describe Robot, "#robot" do

  before(:each) do
    @robot_moth = Robot.new("pet1")
    @robot_moth.name = "pet1_edit"
    @robot_moth.extend(Utility)
    def @robot_moth.my_singleton_method
      return "called singleton method"
    end
    @robot_moth.define_singleton_method(:my_singleton_method2) { "Singleton method 2!" }
    # check for insecure input data from command line
    if @robot_moth.methods.include?(:get_input)
      @robot_moth.taint
    end
    # @robot_moth.freeze
    # @robot_moth.name.freeze # Freeze instance variable of instance object
    @robot_butterfly = @robot_moth.dup
  end

  context "with robot name" do

    it "dup does not duplicate module methods extended into class instance methods as expected" do
      expect(@robot_moth.username).to eq "luke schoen"
      expect{ @robot_butterfly.username }.to raise_error(NoMethodError)
    end

    it "dup does not duplicates singleton methods as expected" do
      expect{ @robot_butterfly.singleton_method(:my_singleton_method) }.to raise_error(NameError) # Dup does not duplicate singleton methods
      expect{ @robot_butterfly.my_singleton_method2 }.to raise_error(NameError)
    end

    it "dup duplicates taints instance methods as expected" do
      expect(@robot_butterfly.tainted?).to eq true # Dup duplicates tainted instance methods
    end

    it "dup duplicates inherited instance variables as expected" do
      expect(@robot_butterfly.manufacturer).to eq "luke schoen"
    end

    it "clones shallow copies and does not allow non-granular changes" do
      @robot_butterfly.name = "pet test"
      expect(@robot_moth.name).to eq "pet1_edit"
    end

    it "clones shallow copies and allows granular changes as expected" do
      @robot_butterfly.name[0] = "again_p"
      expect(@robot_moth.name).to eq "again_pet1_edit"
    end

    # it "dup does not duplicate frozen instances as expected" do
    #   expect(@robot_butterfly.frozen?).to eq false # # Dup DOES NOT duplicate frozen attributes of instance
    #   expect{ @robot_butterfly.name_count = 5 }.to_not raise_error(RuntimeError) # Dup DOES NOT prevent modification of frozen instance
    # end

    # it "dup duplicates frozen attributes of instance variables as expected" do
    #   expect(@robot_butterfly.name.frozen?).to eq true # Dup duplicates frozen attributes of instance
    # end

    # it "dup duplicates frozen attributes and prevents modification when string frozen as expected" do
    #   expect{ @robot_butterfly.name[0] = "z" }.to raise_error(RuntimeError)
    # end

    it "dup as expected" do
      expect(@robot_moth.to_s).to eq "name: pet1_edit"
      expect(@robot_moth.methods.include?(:count)).to eq false # Class methods not visible directly
      # expect(@robot_butterfly.obj_count).to eq 5 # Clone copies class instance methods
      # expect(@robot_butterfly.name_count).to eq 4 # Dup copies instance variable attr_accessor
      expect(@robot_butterfly.to_s).to eq "name: pet1_edit" # Clone copies instance variables of object
      expect(@robot_butterfly.methods.include?(:name)).to eq true # Clone copies instance methods
    end
  end
end