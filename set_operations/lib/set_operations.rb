class SetOperations
  def self.union(set1, set2)
    (set1 + set2).uniq
  end

  def self.intersection(set1, set2)
    set1 & set2
  end

  def self.difference(set1, set2)
    set1 - set2
  end
end
