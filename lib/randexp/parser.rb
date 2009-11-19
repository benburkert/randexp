class Randexp
  class Parser
    def self.parse(source)
      case
      when source =~ /^(.*)(\*|\*\?|\+|\+\?|\?)$/ && balanced?($1, $2)
        parse_quantified($1, $2.to_sym)                                 # ends with *, +, or ?: /(..)?/
      when source =~ /^(.*)\{(\d+)\,(\d+)\}$/ && balanced?($1, $2)
        parse_quantified($1, ($2.to_i)..($3.to_i))                      #ends with a range: /(..){..,..}/
      when source =~ /^(.*)\{(\d+)\}$/ && balanced?($1, $2)
        parse_quantified($1, $2.to_i)                                   #ends with a range: /..(..){..}/
      when source =~ /^\((.*)\)\((.*)\)$/ && balanced?($1, $2)
        union(parse($1), parse($2))                                     #balanced union: /(..)(..)/
      when source =~ /^(\(.*\))\|(\(.*\))$/ && balanced?($1, $2)
        intersection(parse($1), parse($2))                              #balanced intersection: /(..)|(..)/
      when source =~ /^(.*)\|(.*)$/ && balanced?($1, $2)
        intersection(parse($1), parse($2))                              #implied intersection: /..|../
      when source =~ /^(.*)\|\((\(.*\))\)$/ && balanced?($1, $2)
        intersection(parse($1), parse($2))                              #unbalanced intersection: /(..)|((...))/
      when source =~ /^(.+)(\(.*\))$/ && balanced?($1, $2)
        union(parse($1), parse($2))                                     #unbalanced union: /...(...)/
      when source =~ /^\((.*)\)$/ && balanced?($1)
        union(parse($1))                                                #explicit group: /(..)/
      when source =~ /^([^()]*)(\(.*\))$/ && balanced?($1, $2)
        union(parse($1), parse($2))                                     #implied group: /..(..)/
      when source =~ /^(.*)\[\:(.*)\:\]$/
        union(parse($1), random($2))                                    #custom random: /[:word:]/
      when source =~ /^(.*)\\([wsdc])$/
        union(parse($1), random($2))                                    #reserved random: /..\w/
      when source =~ /^(.*)\\(.)$/ || source =~ /(.*)(.|\s)$/
        union(parse($1), literal($2))                                   #end with literal or space: /... /
      else
        nil
      end
    end

    def self.parse_quantified(source, multiplicity)
      case source
      when /^[^()]*$/     then quantify_rhs(parse(source), multiplicity)    #implied union: /...+/
      when /^(\(.*\))$/   then quantify(parse(source), multiplicity)        #group: /(...)?/
      when /^(.*\))$/     then quantify_rhs(parse(source), multiplicity)    #implied union: /...(...)?/
      when /^(.*[^)]+)$/  then quantify_rhs(parse(source), multiplicity)    #implied union: /...(...)...?/
      else quantify(parse(source), multiplicity)
      end
    end

    class << self
      alias_method :[], :parse
    end

    def self.balanced?(*args)
      args.all? {|s| s.count('(') == s.count(')')}
    end

    def self.quantify_rhs(sexp, multiplicity)
      case sexp.first
      when :union
        rhs = sexp.pop
        sexp << quantify(rhs, multiplicity)
      else
        quantify(sexp, multiplicity)
      end
    end

    def self.quantify(lhs, sym)
      [:quantify, lhs, sym]
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
  end
end
