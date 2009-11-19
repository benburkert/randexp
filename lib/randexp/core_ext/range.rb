class Range
  def pick
    to_a.pick
  end

  def of
    pick.of { yield }
  end
end
