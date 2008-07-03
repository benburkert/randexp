require File.dirname(__FILE__) + '/spec_helper'

describe Randexp do
  describe "#parse" do

    describe '("\\w")' do
      it "should be a random sexp" do
        Randexp.parse("\\w").first.should == :random
      end

      it "should hold a word symbol" do
        Randexp.parse("\\w").last.should == :w
      end
    end

    describe '("\\s")' do
      it "should be a literal sexp" do
        Randexp.parse("\\s").first.should == :random
      end

      it "should hold a whitespace symbol " do
        Randexp.parse("\\s").last.should == :s
      end
    end

    describe '("\\d")' do
      it "should be a literal sexp" do
        Randexp.parse("\\d").first.should == :random
      end

      it "should hold a digit character " do
        Randexp.parse("\\d").last.should == :d
      end
    end

    describe '("\\c")' do
      it "should be a literal sexp" do
        Randexp.parse("\\c").first.should == :random
      end

      it "should hold a digit character " do
        Randexp.parse("\\c").last.should == :c
      end
    end

    describe '("(\\w)")' do
      it "should be a random sexp" do
        Randexp.parse("(\\w)").first.should == :random
        Randexp.parse("(\\w)").last.should == :w
      end
    end

    describe '("(\\w)(\\d)")' do
      it "should be a union between random sexp's" do
        Randexp.parse("(\\w)(\\d)").first.should == :union
        Randexp.parse("(\\w)(\\d)")[1].first.should == :random
        Randexp.parse("(\\w)(\\d)")[2].first.should == :random
      end
    end

    describe '("(\\w)(\\s)(\\d)")' do
      it "should be a union between 3 sexp's" do
        Randexp.parse("(\\w)(\\s)(\\d)").first.should == :union
        Randexp.parse("(\\w)(\\s)(\\d)").size.should == 4
      end
    end

    describe '("\\w*")' do
      it "should be a quantify sexp and hold a random sexp" do
        Randexp.parse("\\w*").first.should == :quantify
        Randexp.parse("\\w*")[1].first.should == :random
        Randexp.parse("\\w*")[2].should == :*
      end
    end

    it "should blah" do
      Randexp.parse("(\\w)|(\\d)").should == [:intersection, [:random, :w], [:random, :d]]
    end

    describe '("[:sentence:]")' do
      it "should be a random sexp" do
        Randexp.parse("[:sentence:]").first.should == :random
        Randexp.parse("[:sentence:]").last.should == :sentence
      end
    end
  end

  describe "#generate" do
    it "should return a character" do
      Randexp.new("\\w").generate.should =~ /\w/
    end

    it "should return a word" do
      Randexp.new("\\w+").generate.should =~ /\w+/
    end

    it "should return a word or an empty string" do
      Randexp.new("\\w*").generate.should =~ /\w*/
    end

    it "should return a word with 4 to 5 characters" do
      Randexp.new("\\w{4,5}").generate.should =~ /\w{4,5}/
    end

    it "should return a digit" do
      Randexp.new("\\d").generate.should =~ /\d/
    end

    it "should return a 2 to 10 digit number" do
      Randexp.new("\\d{2,10}").generate.should =~ /\d{2,10}/
    end

    it "should return a digit or empty string" do
      Randexp.new("\\d?").generate.should =~ /\d?/
    end

    it "should return a digit or a character" do
      Randexp.new("\\d|\\w").generate.should =~ /\w|\d/
    end

    it "should return a word or a 3 digit number" do
      Randexp.new("\\d{3}|\\w+").generate.should =~ /\w+|d{3}/
    end

    it "should return a word or number" do
      Randexp.new("\\w+|\\d{3}").generate.should =~ /\w+|d{3}/
    end

    it "should return a sentence" do
      require 'ruby-debug'
      debugger
      Randexp.new("[:sentence:]").generate.should =~ /(\w+\s)*\w+/
    end

    it "should handle a telephone number" do
      100.times do
        Randexp.new("(\\d{3}-)?\\d{3}-\\d{4}").generate.should =~ /(\d{3}-)?\d{3}-\d{4}/
      end
    end
  end
end