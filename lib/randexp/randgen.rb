class Randgen
  WORDS_PER_SENTENCE = 3..20
  SENTENCES_PER_PARAGRAPH = 3..8

  def self.bool(options = {})
    ['true', 'false'].pick
  end

  def self.lchar(options = {})
    ('a'..'z').to_a.pick
  end

  def self.uchar(options = {})
    ('A'..'Z').to_a.pick
  end

  def self.char(options = {})
    [lchar, uchar].pick
  end

  def self.whitespace(options = {})
    ["\t", "\n", "\r", "\f"].pick
  end

  def self.digit(options = {})
    ('0'..'9').to_a.pick
  end

  def self.alpha_numeric(options = {})
    [char, digit].pick
  end

  def self.word(options = {})
    begin
      word = Randexp::Dictionary.words(options).pick
      word ||= options[:length].of { alpha_numeric }.join
    end until word =~ /^\w+$/

    word
  end

  def self.first_name(options = {})
    RealName.first_names(options).pick
  end

  def self.surname(options = {})
    RealName.surnames(options).pick
  end

  class << self
    alias_method :last_name, :surname
  end

  def self.name(options = {})
    "#{first_name(options)} #{surname(options)}"
  end

  def self.email(options = {})
    domain = options.fetch(:domain, "#{word(options)}.example.org")
    "#{word(options)}@#{domain}"
  end

  def self.sentence(options = {})
    ((options[:length] || WORDS_PER_SENTENCE.pick).of { word } * " ").capitalize
  end

  def self.paragraph(options = {})
    ((options[:length] || SENTENCES_PER_PARAGRAPH.pick).of { sentence } * ".  ") + "."
  end

  def self.phone_number(options = {})
    case options[:length]
    when 7  then  /\d{3}-\d{4}/.gen
    when 10 then  /\d{3}-\d{3}-\d{4}/.gen
    else          /(\d{3}-)?\d{3}-\d{4}/.gen
    end
  end
end
