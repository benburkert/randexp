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
        Randexp::Dictionary.words.should include(Randgen.word)
      end
    end

    it "should pick a word with a length if the length option is supplied" do
      10.times do
        length = (3..10).pick
        Randgen.word(:length => length).length.should == length
      end
    end

    it "should not return a string that is not a word" do
      strings = %w[foo's bars]
      Randexp::Dictionary.should_receive(:words).at_least(1).and_return strings

      100.times do
        Randgen.word.should_not == "foo's"
      end
    end
  end

  describe ".first_name" do
    it "should pick a word from the female names list if the gender option is female" do
      100.times do
        female_name = Randgen.first_name(:gender => :female)
        RealName.female_first_names.should include(female_name)
      end
    end

    it "should pick a word from the male names list if the gender option is male" do
      100.times do
        male_name = Randgen.first_name(:gender => :male)
        RealName.male_first_names.should include(male_name)
      end
    end

    it "should pick a word from the male names list with the same length in the options" do
      100.times do
        length = (3..10).pick
        male_name = Randgen.first_name(:length => length)
        (RealName.female_first_names + RealName.male_first_names).should include(male_name)
      end
    end
  end

  describe ".last_name" do
    it "should pick a word from the last names list with the same length in the options" do
      100.times do
        length = (3..10).pick
        last_name = Randgen.last_name(:length => length)
        RealName.surnames.should include(last_name)
      end
    end
  end

  describe ".name" do
    it "should be two words long" do
      100.times do
        Randgen.name.should =~ /\w+ \w+/
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

  describe ".phone_number" do
    it "should match /(\\d{3}-)?\\d{3}-\\d{4}/ when no length is given" do
      100.times do
        Randgen.phone_number =~ /(\d{3}-)?\d{3}-\d{4}/
      end
    end

    it "should match /\\d{3}-\\d{4}/ when the length is 7" do
      100.times do
        Randgen.phone_number(:length => 7) =~ /\d{3}-\d{4}/
      end
    end

    it "should match /\\d{3}-\\d{3}-\\d{4}/ when the length is 10" do
      100.times do
        Randgen.phone_number(:length => 10) =~ /\d{3}-\d{3}-\d{4}/
      end
    end
  end

  it "should generate a first name" do
    100.times do
      Randgen.first_name.should =~ /\w/
    end
  end
  
  it "should generate a male first name" do
    male_list = RealName.male_first_names
    100.times do
      Randgen.first_name(:gender => :male).should =~ /\w/
      male_list.include?(Randgen.first_name(:gender => :male)).should be_true
    end
  end
  
  it "should generate a female first name" do
    female_list = RealName.female_first_names
    100.times do
      Randgen.first_name(:gender => :female).should =~ /\w/
      female_list.include?(Randgen.first_name(:gender => :female)).should be_true
    end
  end
  
  it "should generate a last name" do
    100.times do
      Randgen.last_name.should =~ /\w/
    end
  end
  
  it "should generate a real name" do
    100.times do
      Randgen.name.should =~ /\w{2}/
    end
  end
  
  it "should generate a real male name" do
    male_list = RealName.male_first_names
    100.times do
      name = Randgen.name(:gender => :male)
      name.should =~ /\w{2}/
      male_list.include?(name.split(' ').first).should be_true
    end
  end
  
  it "should generate a real female name" do
    female_list = RealName.female_first_names
    100.times do
      name = Randgen.name(:gender => :female)
      name.should =~ /\w{2}/
      female_list.include?(name.split(' ').first).should be_true
    end
  end
end