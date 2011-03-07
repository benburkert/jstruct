class Hash
  def to_jexp
    inject(self::class.new) do |h, (key, value)|
      h.update key.to_s => value.to_jexp
    end
  end
end
