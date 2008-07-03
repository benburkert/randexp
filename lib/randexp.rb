require 'core_ext/array'
require 'core_ext/integer'
require 'core_ext/range'
require 'core_ext/regexp'
require 'dictionary'
require 'random'

class Randexp
  def self.parse(source)
    case source
    when /^\(([^()]*)\)$/                         then union(parse($1))
    when /(.*)\|(?:([^()]*|\(.*\)))$/             then intersection(parse($1), parse($2))
    when /(.*)\(([^()]*)\)(\*|\*\?|\+|\+\?|\?)$/  then union(parse($1), quantify(parse($2), $3.to_sym))
    when /(.*)\(([^()]*)\)\{(\d+)\,(\d+)\}$/      then union(parse($1), quantify(parse($2), ($3.to_i)..($4.to_i)))
    when /(.*)\(([^()]*)\)\{(\d+)\}$/             then union(parse($1), quantify(parse($2), $3.to_i))
    when /(.*)\(([^()]*)\)$/                      then union(parse($1), parse($2))
    when /(.*)\[:(\w+):\]$/                       then union(parse($1), random($2))
    when /(.*)\\([wsdc])(\*|\*\?|\+|\+\?|\?)$/    then union(parse($1), quantify(random($2), $3.to_sym))
    when /(.*)\\([wsdc])\{(\d+)\,(\d+)\}$/        then union(parse($1), quantify(random($2), ($3.to_i)..($4.to_i)))
    when /(.*)\\([wsdc])\{(\d+)\}$/               then union(parse($1), quantify(random($2), $3.to_i))
    when /(.*)\\([wsdc])$/                        then union(parse($1), random($2))
    when /(.*)(\S)$/                              then union(parse($1), literal($2))
    else nil
    end
  end

  def self.quantify(lhs, sym)
    if lhs.first == :intersection
      lhs << [:quantify, lhs.pop, sym]
    else
      [:quantify, lhs, sym]
    end
  end

  def self.union(lhs, *rhs)
    if lhs.nil?
      union(*rhs)
    elsif rhs.empty?
      lhs
    elsif lhs.first == :union
      rhs.each {|s| lhs << s}
      lhs
    else
      [:union, lhs, *rhs]
    end
  end

  def self.intersection(lhs, rhs)
    if rhs.first == :intersection
      [:intersection, lhs] + rhs[1..-1]
    else
      [:intersection, lhs, rhs]
    end
  end

  def self.random(char)
    [:random, char.to_sym]
  end

  def self.literal(word)
    [:literal, word]
  end

  def initialize(source)
    @sexp = Randexp.parse(source)
  end

  def to_s
    generate
  end

  def generate(sexp = @sexp.dup, quant = nil)
    send(sexp.shift, sexp, quant)
  end

  def quantify(sexp, old_quant)
    generate(*sexp)
  end

  def literal(sexp, quant = nil)
    raise "quantifier (#{quant}) cannot be used on a literal (#{sexp * ''})" unless quant.nil?
    sexp * ""
  end

  def random(sexp, quant)
    case s = sexp.shift
    when :w then char(quant)
    when :s then whitespace(quant)
    when :d then digit(quant)
    else send(s, quant)
    end
  end

  def intersection(sexp, quant)
    case quant
    when :'?'       then ['', sexp.map {|s| generate(s)}.pick].pick
    when :+, :'+?'  then raise "Sorry, \"((...)|(...))+\" is too vague, try setting a range: \"((...)|(...)){1, 3}\""
    when :*, :'*?'  then raise "Sorry, \"((...)|(...))*\" is too vague, try setting a range: \"((...)|(...)){0, 3}\""
    when Range      then quant.pick.of { ssexp.map {|s| generate(s)}.pick } * ''
    when Integer    then quant.of { sexp.map {|s| generate(s)}.pick } * ''
    when nil        then sexp.map {|s| generate(s)}.pick
    end
  end

  def union(sexp, quant)
    case quant
    when :'?'       then ['', sexp.map {|s| generate(s)} * ''].pick
    when :+, :'+?'  then raise "Sorry, \"(...)+\" is too vague, try setting a range: \"(...){1, 3}\""
    when :*, :'*?'  then raise "Sorry, \"(...)*\" is too vague, try setting a range: \"(...){0, 3}\""
    when Range      then quant.pick.of { sexp.map {|s| generate(s)} * '' } * ''
    when Integer    then quant.of { sexp.map {|s| generate(s)} * '' } * ''
    when nil        then sexp.map {|s| generate(s)} * ''
    end
  end

  def char(quant)
    case quant
    when :'?'       then ['', Random.char].pick
    when :+, :'+?'  then Random.word
    when :*, :'*?'  then ['', Random.word].pick
    when Range      then Random.word(:length => quant.pick)
    when 1, nil     then Random.char
    when Integer    then Random.word(:length => quant)
    end
  end

  def whitespace(quant)
    case quant
    when :'?'       then ['', Random.whitespace].pick
    when :+, :'+?'  then raise "Sorry, \"\s+\" is too vague, try setting a range: \"\s{1, 5}\""
    when :*, :'*?'  then raise "Sorry, \"\s*\" is too vague, try setting a range: \"\s{0, 5}\""
    when Range      then quant.pick.of { Random.whitespace } * ''
    when Integer    then quant.of { Random.whitespace } * ''
    when nil        then Random.whitespace
    end
  end

  def digit(quant)
    case quant
    when :'?'       then ['', Random.digit].pick
    when :+, :'+?'  then raise "Sorry, \"\d+\" is too vague, try setting a range: \"\d{1, 5}\""
    when :*, :'*?'  then raise "Sorry, \"\d*\" is too vague, try setting a range: \"\d{0, 5}\""
    when Range      then quant.pick.of { Random.digit } * ''
    when Integer    then quant.of { Random.digit } * ''
    when nil        then Random.digit
    end
  end

  def word(quantity)
    case quantity
    when :'?'       then ['', Random.word].pick
    when :+, :'?'   then Random.sentence
    when :*, :'*?'  then ['', Random.sentence].pick
    when Range      then Random.sentence(:length => quant.pick)
    when nil        then Random.word
    when Integer    then Random.paragraph(:length => quant)
    end
  end

  def sentence(quantity)
    case quantity
    when :'?'       then ['', Random.sentence].pick
    when :+, :'+?'  then Random.paragraph
    when :*, :'*?'  then ['', Random.paragraph].pick
    when Range      then Random.paragraph(:length => quant.pick)
    when 1, nil     then Random.sentence
    when Integer    then Random.paragraph(:length => quant)
    end
  end
end