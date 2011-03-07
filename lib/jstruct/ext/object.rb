class Object
  def to_jexp
    JSON.parse(JSON.dump([self])).first
  end
end
