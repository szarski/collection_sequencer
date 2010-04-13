require File.dirname(__FILE__) + '/../spec_helper.rb'
 
describe "CollectionSequence test -> " do

  describe "basics" do
    it "should create a new instance" do
      @collection_sequence = CollectionSequence.new :ids => [1,2,3], :name => "my_sequece"
      @collection_sequence.save.should be_true
      @collection_sequence.reload.ids.should == [1,2,3]
    end
  end

end
