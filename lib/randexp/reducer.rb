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

    def self.random(sexpish, quantity)
      case s = sexpish.first
      when :w then char(quantity)
      when :s then whitespace(quantity)
      when :d then digit(quantity)
      else randgen(s, quantity)
      end
    end

    def self.literal(cell, quantity = nil)
      case quantity
      when :'?'         then ([''] + cell).pick
      when :+, :'+?'    then raise "Sorry, \"#{cell * ''}+\" is too vague, try setting a range: \"#{cell * ''}{1,3}\""
      when :*, :'*?'    then raise "Sorry, \"#{cell * ''}*\" is too vague, try setting a range: \"#{cell * ''}{0,3}\""
      when Range        then quantity.pick.of { cell * '' } * ''
      when Integer      then quantity.of { cell * '' } * ''
      when nil          then cell * ''
      end
    end

    def self.intersection(cell, quantity)
      case quantity
      when :'?'       then ['', cell.map {|s| reduce(s)}.pick].pick
      when :+, :'+?'  then raise "Sorry, \"((...)|(...))+\" is too vague, try setting a range: \"((...)|(...)){1, 3}\""
      when :*, :'*?'  then raise "Sorry, \"((...)|(...))*\" is too vague, try setting a range: \"((...)|(...)){0, 3}\""
      when Range      then quantity.pick.of { cell.map {|s| reduce(s)}.pick } * ''
      when Integer    then quantity.of { cell.map {|s| reduce(s)}.pick } * ''
      when nil        then cell.map {|s| reduce(s)}.pick
      end
    end

    def self.union(cell, quantity)
      case quantity
      when :'?'       then ['', cell.map {|s| reduce(s)} * ''].pick
      when :+, :'+?'  then raise "Sorry, \"(...)+\" is too vague, try setting a range: \"(...){1, 3}\""
      when :*, :'*?'  then raise "Sorry, \"(...)*\" is too vague, try setting a range: \"(...){0, 3}\""
      when Range      then quantity.pick.of { cell.map {|s| reduce(s)} * '' } * ''
      when Integer    then quantity.of { cell.map {|s| reduce(s)} * '' } * ''
      when nil        then cell.map {|s| reduce(s)} * ''
      end
    end

    def self.char(quantity)
      case quantity
      when :'?'       then ['', Randgen.char].pick
      when :+, :'+?'  then Randgen.word
      when :*, :'*?'  then ['', Randgen.word].pick
      when Range      then Randgen.word(:length => quantity.pick)
      when 1, nil     then Randgen.char
      when Integer    then Randgen.word(:length => quantity)
      end
    end

    def self.whitespace(quantity)
      case quantity
      when :'?'       then ['', Randgen.whitespace].pick
      when :+, :'+?'  then raise "Sorry, \"\\s+\" is too vague, try setting a range: \"\\s{1, 5}\""
      when :*, :'*?'  then raise "Sorry, \"\\s*\" is too vague, try setting a range: \"\\s{0, 5}\""
      when Range      then quantity.pick.of { Randgen.whitespace } * ''
      when Integer    then quantity.of { Randgen.whitespace } * ''
      when nil        then Randgen.whitespace
      end
    end

    def self.digit(quantity)
      case quantity
      when :'?'       then ['', Randgen.digit].pick
      when :+, :'+?'  then raise "Sorry, \"\\d+\" is too vague, try setting a range: \"\\d{1, 5}\""
      when :*, :'*?'  then raise "Sorry, \"\\d*\" is too vague, try setting a range: \"\\d{0, 5}\""
      when Range      then quantity.pick.of { Randgen.digit } * ''
      when Integer    then quantity.of { Randgen.digit } * ''
      when nil        then Randgen.digit
      end
    end

    def self.randgen(args, quantity)
      method_name, _ = *args
      case quantity
      when :'?'       then ['', Randgen.send(method_name, :length => 1)].pick
      when :+, :'+?'  then Randgen.send(method_name)
      when :*, :'*?'  then ['', Randgen.send(method_name)].pick
      when Range      then Randgen.send(method_name, :length => quantity.pick)
      when 1, nil     then Randgen.send(method_name)
      when Integer    then Randgen.send(method_name, :length => quantity)
      end
    end
  end
end
