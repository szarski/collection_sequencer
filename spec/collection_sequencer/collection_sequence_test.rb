require File.dirname(__FILE__) + '/../spec_helper.rb'
 
describe "CollectionSequence test -> " do

  describe "basics" do
    it "should create a new instance" do
      @collection_sequence = CollectionSequence.new :ids => [1,2,3], :name => "my_sequece"
      @collection_sequence.save.should be_true
      @collection_sequence.reload.ids.should == [1,2,3]
    end
  end

  describe "sorting" do
    before :each do
      @collection_sequence = CollectionSequence.create :ids => [1,2,3,4,5,6,7,8,9,0], :name => "my_sequece"
    end

    it "should merge ids on update" do
      @collection_sequence.update_sequence! [4,3,9,8]
      @collection_sequence.reload.ids.should == [1,2,4,3,5,6,7,9,8,0]
    end
  end

end
