class Randexp
  class Reducer
    def self.reduce(sexp, quantity = nil)
      send(sexp.first, sexp[1..-1], quantity)
    end

    class << self
      alias_method :[], :reduce
    end

    def self.quantify(sexp, old_quantity)
      reduce(*sexp)
    end

    def self.random(sexp, quant)
      case s = sexp.first
      when :w then char(quant)
      when :s then whitespace(quant)
      when :d then digit(quant)
      else randgen(s, quant)
      end
    end

    def self.literal(sexp, quantity = nil)
      case quantity
      when :'?'         then ([''] + sexp).pick * ''
      when :+, :'+?'    then raise "Sorry, \"#{sexp * ''}+\" is too vague, try setting a range: \"#{sexp * ''}{1,3}\""
      when :*, :'*?'    then raise "Sorry, \"#{sexp * ''}*\" is too vague, try setting a range: \"#{sexp * ''}{0,3}\""
      when Range        then quant.pick.of { sexp * '' } * ''
      when Integer      then quant.of { sexp * '' } * ''
      when nil          then sexp * ''
      end
    end

    def self.intersection(sexp, quant)
      case quant
      when :'?'       then ['', sexp.map {|s| reduce(s)}.pick].pick
      when :+, :'+?'  then raise "Sorry, \"((...)|(...))+\" is too vague, try setting a range: \"((...)|(...)){1, 3}\""
      when :*, :'*?'  then raise "Sorry, \"((...)|(...))*\" is too vague, try setting a range: \"((...)|(...)){0, 3}\""
      when Range      then quant.pick.of { sexp.map {|s| reduce(s)}.pick } * ''
      when Integer    then quant.of { sexp.map {|s| reduce(s)}.pick } * ''
      when nil        then sexp.map {|s| reduce(s)}.pick
      end
    end

    def self.union(sexp, quant)
      case quant
      when :'?'       then ['', sexp.map {|s| reduce(s)} * ''].pick
      when :+, :'+?'  then raise "Sorry, \"(...)+\" is too vague, try setting a range: \"(...){1, 3}\""
      when :*, :'*?'  then raise "Sorry, \"(...)*\" is too vague, try setting a range: \"(...){0, 3}\""
      when Range      then quant.pick.of { sexp.map {|s| reduce(s)} * '' } * ''
      when Integer    then quant.of { sexp.map {|s| reduce(s)} * '' } * ''
      when nil        then sexp.map {|s| reduce(s)} * ''
      end
    end

    def self.char(quant)
      case quant
      when :'?'       then ['', Randgen.char].pick
      when :+, :'+?'  then Randgen.word
      when :*, :'*?'  then ['', Randgen.word].pick
      when Range      then Randgen.word(:length => quant.pick)
      when 1, nil     then Randgen.char
      when Integer    then Randgen.word(:length => quant)
      end
    end

    def self.whitespace(quant)
      case quant
      when :'?'       then ['', Randgen.whitespace].pick
      when :+, :'+?'  then raise "Sorry, \"\s+\" is too vague, try setting a range: \"\s{1, 5}\""
      when :*, :'*?'  then raise "Sorry, \"\s*\" is too vague, try setting a range: \"\s{0, 5}\""
      when Range      then quant.pick.of { Randgen.whitespace } * ''
      when Integer    then quant.of { Randgen.whitespace } * ''
      when nil        then Randgen.whitespace
      end
    end

    def self.digit(quant)
      case quant
      when :'?'       then ['', Randgen.digit].pick
      when :+, :'+?'  then raise "Sorry, \"\d+\" is too vague, try setting a range: \"\d{1, 5}\""
      when :*, :'*?'  then raise "Sorry, \"\d*\" is too vague, try setting a range: \"\d{0, 5}\""
      when Range      then quant.pick.of { Randgen.digit } * ''
      when Integer    then quant.of { Randgen.digit } * ''
      when nil        then Randgen.digit
      end
    end

    def self.randgen(args, quantity)
      method_name = *args
      case quantity
      when :'?'       then ['', Randgen.send(method_name, :length => 1).to_s].pick
      when :+, :'+?'  then Randgen.send(method_name).to_s
      when :*, :'*?'  then ['', Randgen.send(method_name).to_s].pick
      when Range      then Randgen.send(method_name, :length => quant.pick).to_s
      when 1, nil     then Randgen.send(method_name).to_s
      when Integer    then Randgen.send(method_name, :length => quant).to_s
      end
    end
  end
end