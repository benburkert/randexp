require File.dirname(__FILE__) + '/../spec_helper'

describe Randgen do
  describe ".bool" do
    it "should return 'true' or 'false'" do
      100.times do
        ['true', 'false'].should include(Randgen.bool)
      end
    end
  end

  describe ".lchar" do
    it "should return 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', or 'z'" do
      100.times do
        ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'].should include(Randgen.lchar)
      end
    end
  end

  describe ".uchar" do
    it "should return 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', or 'Z'" do
      100.times do
        ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'].should include(Randgen.uchar)
      end
    end
  end

  describe ".char" do
    it "should return 'A', 'a', 'B', 'b', 'C', 'c', 'D', 'd', 'E', 'e', 'F', 'f', 'G', 'g', 'H', 'h', 'I', 'i', 'J', 'j', 'K', 'k', 'L', 'l', 'M', 'm', 'N', 'n', 'O', 'o', 'P', 'p', 'Q', 'q', 'R', 'r', 'S', 's', 'T', 't', 'U', 'u', 'V', 'v', 'W', 'w', 'X', 'x', 'Y', 'y', 'Z', or 'z'" do
      100.times do
        ['A', 'a', 'B', 'b', 'C', 'c', 'D', 'd', 'E', 'e', 'F', 'f', 'G', 'g', 'H', 'h', 'I', 'i', 'J', 'j', 'K', 'k', 'L', 'l', 'M', 'm', 'N', 'n', 'O', 'o', 'P', 'p', 'Q', 'q', 'R', 'r', 'S', 's', 'T', 't', 'U', 'u', 'V', 'v', 'W', 'w', 'X', 'x', 'Y', 'y', 'Z', 'z'].should include(Randgen.char)
      end
    end
  end

  describe ".whitespace" do
    it "should return '\\t', '\\n', '\\r', or '\\f'" do
      100.times do
        ["\t", "\n", "\r", "\f"].should include(Randgen.whitespace)
      end
    end
  end

  describe ".digit" do
    it "should return '0', '1', '2', '3', '4', '5', '6', '7', '8', or '9'" do
      100.times do
        ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].should include(Randgen.digit)
      end
    end
  end

  describe ".alpha_numeric" do
    it "should return 'A', 'a', 'B', 'b', 'C', 'c', 'D', 'd', 'E', 'e', 'F', 'f', 'G', 'g', 'H', 'h', 'I', 'i', 'J', 'j', 'K', 'k', 'L', 'l', 'M', 'm', 'N', 'n', 'O', 'o', 'P', 'p', 'Q', 'q', 'R', 'r', 'S', 's', 'T', 't', 'U', 'u', 'V', 'v', 'W', 'w', 'X', 'x', 'Y', 'y', 'Z', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', or '9'" do
      100.times do
        ['A', 'a', 'B', 'b', 'C', 'c', 'D', 'd', 'E', 'e', 'F', 'f', 'G', 'g', 'H', 'h', 'I', 'i', 'J', 'j', 'K', 'k', 'L', 'l', 'M', 'm', 'N', 'n', 'O', 'o', 'P', 'p', 'Q', 'q', 'R', 'r', 'S', 's', 'T', 't', 'U', 'u', 'V', 'v', 'W', 'w', 'X', 'x', 'Y', 'y', 'Z', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].should include(Randgen.alpha_numeric)
      end
    end
  end

  describe ".word" do
    it "should pick an entry from Dictionary" do
      10.times do
        Dictionary.words.should include(Randgen.word)
      end
    end

    it "should pick a word with a length if the length option is supplied" do
      10.times do
        length = (3..10).pick
        Randgen.word(:length => length).length.should == length
      end
    end
  end

  describe ".sentence" do
    it "should be capitalized" do
      10.times do
        Randgen.sentence.should =~ /^[A-Z]/
      end
    end
  end

  describe ".paragraph" do
    it "should end in a period" do
      10.times do
        Randgen.paragraph.should =~ /\.$/
      end
    end
  end
end