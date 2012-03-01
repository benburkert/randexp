require File.expand_path('../../../spec_helper', __FILE__)

describe Regexp do
  describe "#gen" do
    it "should always return a string" do
      /abcd/.gen.class.should == String
    end
  end
end
