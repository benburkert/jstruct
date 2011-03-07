module JStruct
  class JClass
    extend Forwardable

    def_delegator :to_hash, :to_jexp
    def_delegator :to_jexp, :to_json

    def self.from(data)
      case data
      when String   then from(JSON.parse(data))
      when Array    then data.map {|o| from(o) }
      when Hash     then from_hash(data)
      when NilClass then nil
      else raise("Can't parse a #{data.class} into a #{self}")
      end
    end

    def self.from_hash(hash)
      attributes = hash.inject({}) do |h, (member, value)|
        if complex_members.keys.include?(member.to_sym)
          klass = complex_members[member.to_sym]
          value = klass.from(value)
        end
      h.update(member.to_sym => value)
      end

      new(attributes)
    end

    def self.inherited(klass)
      %w[ simple_members complex_members ].each do |accessor|
        klass.class_eval("def self.#{accessor} ; @@#{accessor} ; end", __FILE__, __LINE__ + 1)
        klass.class_eval("def self.#{accessor}=(val) ; @@#{accessor} = val ; end", __FILE__, __LINE__ + 1)
      end
    end

    def self.set_members!(simple_members, complex_members)
      self.simple_members  = simple_members
      self.complex_members = complex_members

      attr_accessor(*(simple_members + complex_members.keys))
    end

    def initialize(attributes)
      attributes.each do |member, value|
        send(:"#{member}=", value)
      end
    end

    def members
      self::class.simple_members + self::class.complex_members.keys
    end

    def to_hash
      members.inject({}) {|h, k| h.update(k => send(k.to_sym)) }
    end

    def to_s
      "#<jstruct #{self.class.inspect} #{to_hash.inspect} >"
    end

    alias_method :inspect, :to_s

    def ==(other)
      members.all? {|member| send(member) == other.send(member) }
    end
  end
end
