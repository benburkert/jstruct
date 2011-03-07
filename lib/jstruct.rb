require 'forwardable'
require 'json'

module JStruct
  def self.new(*simple_members)
    complex_members = simple_members.last.is_a?(Hash) ? simple_members.pop : {}

    klass = Class.new(JClass)
    klass.set_members!(simple_members, complex_members)
    klass
  end
end

require 'jstruct/jclass'
require 'jstruct/ext/array'
require 'jstruct/ext/hash'
require 'jstruct/ext/integer'
require 'jstruct/ext/object'
require 'jstruct/ext/string'
