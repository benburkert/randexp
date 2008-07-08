require File.dirname(__FILE__) + '/../../spec_helper'

describe Regexp do
  describe "#gen" do
    it "should always return a string" do
      /abcd/.gen.class.should == String
    end
  end
end