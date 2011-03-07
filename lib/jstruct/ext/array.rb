class Array
  def to_jexp
    map {|o| o.to_jexp }
  end
end
