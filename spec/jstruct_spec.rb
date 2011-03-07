require 'spec_helper'

describe JStruct do
  it 'can roundtrip JSON' do
    klass = Class.new(JStruct.new(:foo, :bar))
    JSON.parse(klass.new(:foo => 'abc', :bar => 123).to_json)
  end

  it 'can handle complex members' do
    klass1 = Class.new(JStruct.new(:a, :b))
    klass2 = Class.new(JStruct.new(:c, :d => klass1))

    original = klass2.new(:c => [1], :d => klass1.new(:a => 'a', :b => 1))

    klass2.from(original.to_json).should == original
  end
end
