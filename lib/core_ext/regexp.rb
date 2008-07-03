class Regexp
  def generate
    Randexp.new(source).generate
  end

  alias_method :gen, :generate
end