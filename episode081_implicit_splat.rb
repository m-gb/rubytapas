require 'set'
a = [:first, :second, :third, :fourth]
s = Set.new(a)
# => #<Set: {:first, :second, :third, :fourth}>
s.to_a                          # => [:first, :second, :third, :fourth]. when we substitute a Set for our array, the implicit splatting no longer works.
x, y, z = s
x                               # => #<Set: {:first, :second, :third, :fourth}>
y                               # => nil
z                               # => nil
# if we rely on implicit splatting, the input must be an actual Array or something very close to one.
x, y, z = *s
x                               # => :first
y                               # => :second
z                               # => :third
# in the block argument list, it causes the pair to be wrapped in a second array.
def yield_pair
  yield([:foo, :bar])
end

yield_pair do |*pair|
  puts pair.inspect
end
# >> [[:foo, :bar]]
# If we want to work with keys and values separately, we can provide a block that takes two separate arguments.
# But if we want to work with key/value pairs as a unit, we can supply just one block argument.
