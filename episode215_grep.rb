open("jabberwocky.txt").each_line.grep(/Jabberwock/) # the File#each_line method returns an enumerator over a file's lines. we pass a regex.
# => ["\"Beware the Jabberwock, my son!\n",
#     "The Jabberwock, with eyes of flame,\n",
#     "\"And hast thou slain the Jabberwock?\n"]

# passing a block to #grep:
open("jabberwocky.txt").each_line.grep(/Jabberwock/) do |line|
  puts "MATCH: #{line}"
end
# >> MATCH: "Beware the Jabberwock, my son!
# >> MATCH: The Jabberwock, with eyes of flame,
# >> MATCH: "And hast thou slain the Jabberwock?

# we can break out early, without the expense of processing all of the elements.
open("jabberwocky.txt").each_line.grep(/Jabberwock/) do |line|
  break if line =~ /slain/
  puts "MATCH: #{line}"
end
# >> MATCH: "Beware the Jabberwock, my son!
# >> MATCH: The Jabberwock, with eyes of flame,

# grep can be used to match any kind of object in a collection
# it makes use of Ruby's “case-equality”, or “threequals” operator. 
case object
when 23 then "the number 23" # matches an object based on value
when /foo/ then "contains foo" # a matching regex
when Float then "a floating-point number" # the class
when /2..10/ then "between 2 and 10" # a range of values
end

# comparing the argument against the collection's elements using the threequals operator:
[87, 23, 15, 74, 62, 42, 91].grep(0..50)
# => [23, 15, 42]
(0..50) === 23                    # => true
(0..50) === 87                    # => false

# inventing our own pattern objects for matching, since #grep implements the threequals:
# we want to find ratios based on their from and to properties.
class Feet; end
class Meters; end

ConversionRatio = Struct.new(:from, :to, :number) do
  def self.registry
    @registry ||= []
  end

  def self.find(from, to)                                                 # one way: passing a block to #detect.
    registry.detect{|ratio| ratio.from == from && ratio.to == to} 
  end
end

ConversionRatio.registry << 
  ConversionRatio.new(Feet, Meters, 0.3048) <<
  ConversionRatio.new(Meters, Feet, 3.28084)


require "./ratio"

RatioPattern = Struct.new(:from, :to) do
  def ===(other)
    from == other.from && to == other.to
  end
end

ConversionRatio.registry.grep(RatioPattern.new(Feet, Meters))             # second way: grep with an instance of this object.
# => [#<struct ConversionRatio from=Feet, to=Meters, number=0.3048>]

# third way : set up a lambda that lookds for what we want, passing it to #grep:
require "./ratio"

pattern = ->(ratio) { ratio.from == Meters && ratio.to == Feet }
ConversionRatio.registry.grep(pattern)                            # Ruby Proc objects alias threequals to the #call method (the pattern variable.
# => [#<struct ConversionRatio from=Meters, to=Feet, number=3.28084>]
# pattern === ConversionRatio.new(Meters, Feet, 3.28084) # => true














# with #grep we pass the pattern as an argument