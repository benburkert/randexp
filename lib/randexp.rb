class Randexp
  attr_accessor :sexp

  def initialize(source)
    @sexp = Randexp::Parser[source]
  end

  def reduce
    Reducer[@sexp.dup]
  end
end

dir = File.dirname(__FILE__) + '/randexp'
require dir + '/version'
require dir + '/core_ext'
require dir + '/dictionary'
require dir + '/parser'
require dir + '/randgen'
require dir + '/reducer'
require dir + '/wordlists/female_names'
require dir + '/wordlists/male_names'
require dir + '/wordlists/real_name'
