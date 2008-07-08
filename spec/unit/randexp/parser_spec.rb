require File.dirname(__FILE__) + '/../../spec_helper'

describe Randexp::Parser do
  describe ".parse" do
    it "should return a sexp for a non-empty string" do
      Randexp::Parser.parse("abc").should be_instance_of(Array)
    end

    it "should return nil for an empty string" do
      Randexp::Parser.parse("").should be_nil
    end

    it "should alias :[] to :parse" do
      Randexp::Parser[""].should be_nil
    end
  end

  describe ".quantify" do
    it "should return a :quantify sexp" do
      Randexp::Parser.quantify([:literal, 'a'], :*)[0].should == :quantify
    end

    it "should push the quantify symbol on the end of the sexp" do
      Randexp::Parser.quantify([:literal, 'a'], :*).last.should == :*
    end

    it "should push the argument sexp to the first entry of the :quantify sexp" do
      Randexp::Parser.quantify([:literal, 'a'], :*)[1].should == [:literal, 'a']
    end
  end

  describe ".union" do
    it "should return the union of the right-hand side if the left-hand side is nil" do
      Randexp::Parser.union(nil, [:literal, 'a']).should == Randexp::Parser.union([:literal, 'a'])
    end

    it "should return the left-hand side if the right hand side is not present" do
      Randexp::Parser.union([:literal, 'a']).should == [:literal, 'a']
    end

    it "should append the right-hand side(s) to the left-hand side if the left-hand side is a union sexp" do
      Randexp::Parser.union([:union, [:literal, 'a'], [:literal, 'b']], [:literal, 'c']).should == [:union, [:literal, 'a'], [:literal, 'b'], [:literal, 'c']]
    end

    it "should return a :union sexp between the left-hand and right-hand sexp's" do
      Randexp::Parser.union([:literal, 'a'], [:literal, 'b']).should == [:union, [:literal, 'a'], [:literal, 'b']]
    end
  end

  describe ".intersection" do
    it "should prepend the left-hand side onto the right-hand side :intersection sexp if the right-hand side is an :intersection sexp" do
      Randexp::Parser.intersection([:literal, 'a'], [:intersection, [:literal, 'b'], [:literal, 'c']]).should == [:intersection, [:literal, 'a'], [:literal, 'b'], [:literal, 'c']]
    end

    it "should create an :intersection sexp between the left-hand and right-hand sexp's" do
      Randexp::Parser.intersection([:literal, 'a'], [:literal, 'b']).should == [:intersection, [:literal, 'a'], [:literal, 'b']]
    end
  end

  describe ".random" do
    it "should return a :random sexp" do
      Randexp::Parser.random('w').should be_instance_of(Array)
      Randexp::Parser.random('w').first.should == :random
    end

    it "should convert the char parameter to a symbol" do
      Randexp::Parser.random('w').last.should == :w
    end
  end

  describe ".literal" do
    it "should return a literal sexp" do
      Randexp::Parser.literal('a').should be_instance_of(Array)
      Randexp::Parser.literal('a').first.should == :literal
    end
  end
end