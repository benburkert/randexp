class Randexp
  attr_accessor :sexp

  def initialize(source)
    @sexp = Randexp::Parser[source]
  end

  def reduce
    Reducer[@sexp.dup]
  end
end

require 'core_ext'
require 'randexp/parser'
require 'randexp/reducer'
require 'randgen'
require 'dictionary'