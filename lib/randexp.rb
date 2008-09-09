class Randexp
  attr_accessor :sexp

  def initialize(source)
    @sexp = Randexp::Parser[source]
  end

  def reduce
    Reducer[@sexp.dup]
  end
end

dir = File.dirname(__FILE__)
require dir + '/core_ext'
require dir + '/randexp/parser'
require dir + '/randexp/reducer'
require dir + '/randgen'
require dir + '/dictionary'
require dir + '/wordlists/real_name'