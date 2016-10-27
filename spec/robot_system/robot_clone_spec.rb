require_relative '../../robot_system/robot.rb'
require_relative '../../helpers/unfreeze.rb'
require_relative '../../helpers/utility.rb'

RSpec.describe Robot, "#robot" do

  before(:each) do
    @robot_moth = Robot.new("pet1")
    @robot_moth.name = "pet1_edit"
    @robot_moth.extend(Utility)
    @robot_moth_method = @robot_moth.method(:show_manufacturer)
    def @robot_moth.my_singleton_method; return "called singleton method"; end
    @robot_moth.define_singleton_method(:my_singleton_method2) { return "Singleton method 2!" }
    # Open the singleton class of an object with the syntax `class << obj` to see this is where singleton methods (aka class methods) are defined
    @singleton_class = ( class << @robot_moth; self; end )
    # check for insecure input data from command line
    if @robot_moth.methods.include?(:get_input)
      @robot_moth.taint
    end
    # @robot_moth.freeze # Freeze instance object
    # @robot_moth.name.freeze # Freeze instance variable of instance object
    @robot_butterfly = @robot_moth.clone # shallow clone
    # @robot_butterfly.inspect
    @robot_moth.physical = [{ diameter: 100 }, { weight: 1200 }]
    @robot_condor = @robot_moth.dclone # deep clone
  end

  context "with robot name" do

    it "deep clone as expected" do
      expect(@robot_condor.physical[0][:diameter]).to eq 100
    end

    # http://ruby-doc.org/core-2.3.1/Object.html#method-i-singleton_method
    it "clone duplicates module methods extended into class instance methods as expected" do
      expect(@robot_moth.username).to eq "luke schoen"
      expect(@robot_butterfly.username).to eq "luke schoen"
    end

    it "clone duplicates singleton methods as expected" do
      expect(@robot_butterfly.my_singleton_method).to eq "called singleton method" # Clone duplicates singleton methods
      expect(@robot_butterfly.my_singleton_method2).to eq "Singleton method 2!"
    end

    # it "clone unfreezes a frozen object using Fiddle library as expected" do
    #   expect(@robot_butterfly.frozen?).to eq true
    #   @robot_butterfly.unfreeze
    #   expect(@robot_butterfly.frozen?).to eq false
    # end

    it "clone duplicates taints instance methods as expected" do
      expect(@robot_butterfly.tainted?).to eq true # Clone duplicates tainted instance methods
    end

    it "clone duplicates inherited instance variables as expected" do
      expect(@robot_butterfly.instance_of? Robot).to eq true
      expect(@robot_butterfly.is_a? Machine).to eq true
      expect(@robot_butterfly.is_a? ClassLevelInheritableAttributeList).to eq true # due to `include`
      expect(@robot_butterfly.manufacturer).to eq "luke schoen"
      expect(@robot_butterfly.instance_variable_set(:@manufacturer, 'god')).to eq "god"
      expect(@robot_butterfly.instance_variable_get(:@manufacturer)).to_not eq "luke schoen"
      expect(@robot_butterfly.respond_to? :show_manufacturer).to eq true
      expect(@robot_moth_method.call).to eq "luke schoen"
      @robot_moth.remove_instance_variable(:@manufacturer)
      expect(@robot_butterfly.manufacturer).to_not eq nil

      # Instance methods are methods of a class defined in the class definition
      expect(Robot.method_defined? :name).to eq true

      # Class methods are singleton methods defined on the singleton class (`Class` instance) of an object (not defined in the class definition)
      expect(Robot.method_defined? :my_singleton_method).to eq false

      # http://stackoverflow.com/questions/212407/what-exactly-is-the-singleton-class-in-ruby
      expect(@singleton_class.method_defined? :my_singleton_method).to eq true
    end

    it "clones shallow copies and does not allow non-granular changes" do
      @robot_butterfly.name = "pet test"
      expect(@robot_moth.name).to eq "pet1_edit" # no change
    end

    it "clones shallow copies and allows granular changes as expected" do
      @robot_butterfly.name[0] = "again_p"
      expect(@robot_moth.name).to eq "again_pet1_edit"
    end

    it "clone deep copies (duplicate instance independent of original) as expected" do
      # @robot_butterfly.name = "pet test"
      # expect(@robot_moth.name).to_not eq "pet test"
    end

    # it "clone duplicates frozen instances as expected" do
    #   # expect(@robot_butterfly.frozen?).to eq true # Clone duplicates frozen instances
    #   # expect{ @robot_butterfly.name_count = 5 }.to raise_error(RuntimeError) # Clone prevents modification of frozen instance
    # end
    #
    # it "clone duplicates frozen attributes of instance variables as expected" do
    #   expect(@robot_butterfly.name.frozen?).to eq true # Clone duplicates frozen attributes of instance
    #   @robot_butterfly.name = "pet2"
    #   expect{ @robot_butterfly.name = "pet2" }.to raise_error(RuntimeError)
    #   expect(@robot_butterfly.name).to eq "pet2"
    # end

    it "clone as expected" do
      expect(@robot_moth.to_s).to eq "name: pet1_edit"
      expect(@robot_moth.methods.include?(:count)).to eq false # Class methods not visible directly
      # expect(@robot_butterfly.obj_count).to eq 1 # Clone copies class instance methods
      # expect(@robot_butterfly.name_count).to eq 4 # Clone copies instance variable attr_accessor
      expect(@robot_butterfly.to_s).to eq "name: pet1_edit" # Clone copies instance variables of object
      expect(@robot_butterfly.methods.include?(:name)).to eq true # Clone copies instance methods
    end

  end
end