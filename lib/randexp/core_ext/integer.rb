class Integer
  def of
    (1..self).to_a.map { yield }
  end
end
