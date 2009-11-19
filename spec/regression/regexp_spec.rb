require File.dirname(__FILE__) + '/../spec_helper'

describe "#{'*' * 80}\nRegression Specs:" do
  it "/abcd/                          => 'abcd'" do
    100.times do
      /abcd/.gen.should == 'abcd'
    end
  end

  it "/(abcd)|(defg)/                 => ['abcd', 'defg']" do
    100.times do
      ['abcd', 'defg'].should include(/(abcd)|(defg)/.gen)
    end
  end

  it "/(abcd)|(defg)|(hijk)/          => ['abcd', 'defg', 'hijk']" do
    100.times do
      ['abcd', 'defg', 'hijk'].should include(/(abcd)|(defg)|(hijk)/.gen)
    end
  end

  it "/((abcd)|(defg))|(hijk)/        => ['abcd', 'defg', 'hijk']" do
    100.times do
      ['abcd', 'defg', 'hijk'].should include(/((abcd)|(defg))|(hijk)/.gen)
    end
  end

  it "/(abcd)|((defg)|(hijk))/        => ['abcd', 'defg', 'hijk']" do
    100.times do
      ['abcd', 'defg', 'hijk'].should include(/(abcd)|((defg)|(hijk))/.gen)
    end
  end

  it "/(abc)def(ghi)/                 => 'abcdefghi'" do
    100.times do
      /(abc)def(ghi)/.gen.should == 'abcdefghi'
    end
  end

  it "/(((abc)))/                     => 'abc'" do
    100.times do
      /(((abc)))/.gen.should == 'abc'
    end
  end

  it "/ab(c(def))/                    => 'abcdef'" do
    100.times do
      /ab(c(def))/.gen.should == 'abcdef'
    end
  end

  it "/(\\w+)/                         => /\\w+/" do
    100.times do
      /(\w+)/.gen.should =~ /\w+/
    end
  end

  it "/\\w+ \\w+/                       => /\\w+\\s\\w+/" do
    100.times do
      /\w+ \w+/.gen.should =~ /\w+\s\w+/
    end
  end

  it "/\\w*/                           => /(\\w+)|/" do
    100.times do
      /\w*/.gen.should =~ /(\w+)|/
    end
  end

  it "/\\w{2,5}/                       => /\\w{2,5}/" do
    100.times do
      /\w{2,5}/.gen.should =~ /\w{2,5}/
    end
  end

  it "/\\w{1}/                         => /\\w/" do
    100.times do
      /\w{1}/.gen.should =~ /\w/
    end
  end

  it "/\\w{4}/                         => /\\w{4}/" do
    100.times do
      /\w{4}/.gen.should =~ /\w{4}/
    end
  end

  it "/[:word:]/                      => /\\w+/" do
    100.times do
      /[:word:]/.gen.should =~ /\w+/
    end
  end

  it "/[:bool:]/                      => /true|false/" do
    /[:bool:]/.gen.should =~ /true|false/
  end

  it "/[:sentence:]/                  => /(\w+ )*/" do
    100.times do
      /[:sentence:]/.gen.should =~ /(\w+ )*/
    end
  end

  it "/[:paragraph:]/                 => /(  (\w+ )*\.)*/" do
    100.times do
      /[:paragraph:]/.gen.should =~ /(\w+ )*/
    end
  end

  it "/(abc|def){1,2}/                => ['abc', 'def', 'abcabc', 'abcdef', 'defabc', 'defdef']" do
    100.times do
      ['abc', 'def', 'abcabc', 'abcdef', 'defabc', 'defdef'].should include(/(abc|def){1,2}/.gen)
    end
  end

  it "/abc(def)?hij/                  => /abc(def)?hij/" do
    100.times do
      /abc(def)?hij/.gen.should =~ /abc(def)?hij/
    end
  end

  it "/ab(c(def))?h/                  => /ab(c(def))?h/" do
    100.times do
      /ab(c(def))?h/.gen.should =~ /ab(c(def))?h/
    end
  end

  it "/(\\d{3}-)?\\d{3}-\\d{4}/          => /(\\d{3}-)?\\d{3}-\\d{4}/" do
    100.times do
      /(\d{3}-)?\d{3}-\d{4}/.gen.should =~ /(\d{3}-)?\d{3}-\d{4}/
    end
  end

  it "/[:phone_number:]/              => /(\\d{3}-)?\\d{3}-\\d{4}/" do
    100.times do
      /[:phone_number:]/.gen.should =~ /(\d{3}-)?\d{3}-\d{4}/
    end
  end

  it "/[:phone_number:]{7}/           => /\\d{3}-\\d{4}/" do
    100.times do
      /[:phone_number:]{7}/.gen.should =~ /\d{3}-\d{4}/
    end
  end

  it "/[:phone_number:]{10}/          => /\\d{3}-\\d{3}-\\d{4}/" do
    100.times do
      /[:phone_number:]{10}/.gen.should =~ /\d{3}-\d{3}-\d{4}/
    end
  end

  it "/\\w+@\\w+\\.(com|org|net)/        => /\\w+@\\w+\\.(com|org|net)/.gen" do
    100.times do
      /\w+@\w+\.(com|org|net)/.gen.should =~ /\w+@\w+\.(com|org|net)/
    end
  end

  it "/\\$\\d{2,3}\\.\\d{2}/              => /\\$\\d{2,3}\\.\\d{2}/" do
    100.times do
      /\$\d{2,3}\.\d{2}/.gen.should =~ /\$\d{2,3}\.\d{2}/
    end
  end
  
  it "/[:first_name:]/                => /\\w+/" do
    100.times do
      /[:first_name:]/.gen.should =~ /\w+/
    end
  end

  it "/[:last_name:]/                 => /\\w+/" do
    /[:last_name:]/.gen.should =~ /\w+/
  end

  it "/[:name:]/                      => /\\w+ \\w+/" do
    /[:name:]/.gen.should =~ /\w+ \w+/
  end

  it "/[:last_name:]{5,10}/           => /\\w{5,10}/" do
    /[:last_name:]{5,10}/.gen.should =~ /\w{5,10}/
  end

  it "/[:first_name:]{5,10}/          => /\\w{5,10}/" do
    /[:first_name:]{5,10}/.gen.should =~ /\w{5,10}/
  end
end
