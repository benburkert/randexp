class Range
  def pick
    to_a.pick
  end

  def of(&blk)
    pick.of(&blk)
  end
end