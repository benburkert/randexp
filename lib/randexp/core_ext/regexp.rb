class Regexp
  def generate
    Randexp.new(source).reduce
  end

  alias_method :gen, :generate
end
