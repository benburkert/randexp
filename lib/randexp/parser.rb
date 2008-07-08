class Randexp
  class Parser
    def self.parse(source)
      case source
      when /^\(([^()]*|\(.*\))\)$/                  then union(parse($1))
      when /(.*)\|(?:(\({2,}.*\){2,}|[^()]*))$/     then intersection(parse($1), parse($2))
      when /(.*)\|(\(.*\))$/                        then intersection(parse($1), parse($2))
      when /(.*)\(([^()]*)\)(\*|\*\?|\+|\+\?|\?)$/  then union(parse($1), quantify(parse($2), $3.to_sym))
      when /(.*)\(([^()]*)\)\{(\d+)\,(\d+)\}$/      then union(parse($1), quantify(parse($2), ($3.to_i)..($4.to_i)))
      when /(.*)\(([^()]*)\)\{(\d+)\}$/             then union(parse($1), quantify(parse($2), $3.to_i))
      when /(.*)\(([^()]*)\)$/                      then union(parse($1), parse($2))
      when /(.*)\[:(\w+):\](\*|\*\?|\+|\+\?|\?)$/   then union(parse($1), quantify(random($2), $3.to_sym))
      when /(.*)\[:(\w+):\]\{(\d+)\,(\d+)\}$/       then union(parse($1), quantify(random($2), ($3.to_i)..($4.to_i)))
      when /(.*)\[:(\w+):\]\{(\d+)\}$/              then union(parse($1), quantify(random($2), $3.to_i))
      when /(.*)\[:(\w+):\]$/                       then union(parse($1), random($2))
      when /(.*)\\([wsdc])(\*|\*\?|\+|\+\?|\?)$/    then union(parse($1), quantify(random($2), $3.to_sym))
      when /(.*)\\([wsdc])\{(\d+)\,(\d+)\}$/        then union(parse($1), quantify(random($2), ($3.to_i)..($4.to_i)))
      when /(.*)\\([wsdc])\{(\d+)\}$/               then union(parse($1), quantify(random($2), $3.to_i))
      when /(.*)\\([wsdc])$/                        then union(parse($1), random($2))
      when /(.*)(.|\s)$/                            then union(parse($1), literal($2))
      else nil
      end
    end

    class << self
      alias_method :[], :parse
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