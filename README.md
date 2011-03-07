# jstruct

A simple library for crafting objects that can be dumped & loaded to JSON.

# Basics

A JStruct object acts alot like a normal ruby struct, with a few key
differences.

Use `JStruct.new` to create a new subclass:

    class Animal < JStruct.new(:name, :colors)
      def striped?
        colors.size >= 2
      end
    end

Initialize a new instance with an ostruct-style hash:

    zebra = Animal.new(:name => 'Zebra', :colors => %w[ white black ])
      #=> #<jstruct Animal {:colors=>["white", "black"], :name=>"Zebra"}>
    zebra.striped?
      #=> true
    zebra.to_json
      #=> "{\"name\":\"Zebra\",\"colors\":[\"white\",\"black\"]}"

## Complex Members

JStruct members that correspond to JSON primitives (`String`, `Numeric`, `Array`,
or `Hash` objects) can be serialized & deserialized. Normal members that are
complex objects can be serialized to a normal JSON object and
desirialized to a `Hash`.

Complex members can be deserialized back into their original type if
a type is included in the member argument:

    class Zoo < JStruct.new(:name, :animals => Animal) ; end

    zoo = Zoo.new(:name => 'SF Zoo', :animals => [zebra])
      => #<jstruct Zoo {:animals=>[#<jstruct Animal {:colors=>["white", "black"], :name=>"Zebra"} >], :name=>"SF Zoo"} >

    zoo.to_json
      #=> "{\"name\":\"SF Zoo\",\"animals\":[{\"name\":\"Zebra\",\"colors\":[\"white\",\"black\"]}]}"

    Zoo.from(zoo.to_json)
      #=> #<jstruct Zoo {:animals=>[#<jstruct Animal {:colors=>["white", "black"], :name=>"Zebra"} >], :name=>"SF Zoo"} >
