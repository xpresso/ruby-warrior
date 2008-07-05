require File.dirname(__FILE__) + '/../../spec_helper'

describe RubyWarrior::Abilities::Attack do
  before(:each) do
    @attacker = stub(:position => stub)
    @attack = RubyWarrior::Abilities::Attack.new(@attacker)
  end
  
  it "should subtract one from health when performing" do
    receiver = Struct.new(:health).new(5)
    @attack.stubs(:get).returns(receiver)
    receiver.health = 10
    @attack.perform
    receiver.health.should == 9
  end
  
  it "should do nothing if recipient doesn't respond to health" do
    @attack.stubs(:get).returns(Object.new)
    lambda { @attack.perform }.should_not raise_error(Exception)
  end
  
  it "should get object at position from offset" do
    @attacker.position.expects(:get_relative).with(1, 0)
    @attack.get(:forward)
  end
end
