class Random
  WORDS_PER_SENTENCE = 3..20
  SENTENCES_PER_PARAGRAPH = 3..8
  
  def self.bool
    [true, false].pick
  end

  def self.lchar
    ('a'..'z').to_a.pick
  end

  def self.uchar
    ('A'..'Z').to_a.pick
  end

  def self.char
    [lchar, uchar].pick
  end

  def self.whitespace
    ["\t", "\n", "\r", "\f"].pick
  end

  def self.digit
    ('0'..'9').to_a.pick
  end

  def self.word(options = {})
    Dictionary.words(options).pick
  end

  def self.sentence(options = {})
    ((options[:length] || WORDS_PER_SENTENCE.pick).of { word } * " ").capitalize
  end

  def self.paragraph(options = {})
    ((options[:length] || SENTENCES_PER_PARAGRAPH.pick).of { sentence } * ".  ") + "."
  end
end