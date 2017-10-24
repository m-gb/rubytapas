# This syntax doesn't always play well with larger expressions.
1..10.include?(5)               # =>
# ~> -:1:in `<main>': undefined method `include?' for 10:Fixnum (NoMethodError)
# Ruby parsed the expression like this: 1..(10.include?(5)). Because of these parsing issues, we commonly see ranges included in parentheses.

# Inclusive range
(1..10).include?(10)            # => true 
# Exclusive range
(1...10).include?(10)           # => false
# #member is the alias
(1..10).member?(10)             # => true
# The threequals operator performs the same operation.
(1..10) === 5                   # => true

case spaceball_one_speed
when 0...299_792_458
  puts "sublight speed"
when 299_792_458
  puts "light speed"
when 299_792_459...1_000_000_000
  puts "ridiculous speed"
when 1_000_000_000...10_000_000_000
  puts "ludicrous speed"
end

# Filtering out readings using grep.
readings = [26, 72, 9000, 8, 17, -3400]
readings.grep(0..100)
# => [26, 72, 8, 17]

# Ranges are not limited to using numbers.
("a".."z").include?("x")        # => true

this_week = Time.new(2014, 7, 20)...Time.new(2014, 7, 27)
# Asking if it includes today.
this_week.include?(Time.new(2014, 7, 22))
  # =>
# ~> -:2:in `each': can't iterate from Time (TypeError)    # This means it has to know how to increment the start value.
# ~>    from -:2:in `include?'
# ~>    from -:2:in `include?'
# ~>    from -:2:in `<main>'
1.succ                          # => 2
"a".succ                        # => "b"
Time.now.succ                   # => 2014-07-22 11:50:03 -0400 # !> Time#succ is obsolete; use time + 1

# Using #cover instead.
this_week = Time.new(2014, 7, 20)...Time.new(2014, 7, 27)
this_week.cover?(Time.new(2014, 7, 22))
  # => true

# Selecting the entries for this week.
marvin_calendar = {
  Time.new(2014, 7, 20) => "Mope",
  Time.new(2014, 7, 22) => "Rust",
  Time.new(2014, 7, 28) => "Write sad poem"
}

this_week = Time.new(2014, 7, 20)...Time.new(2014, 7, 27)

marvin_calendar.select{|date, _| this_week.cover?(date) }.values
# => ["Mope", "Rust"]

# For ranges that can be iterated, Ruby provides an #each method, along with the usual Enumerable methods.
(0..10).each do |n|
  puts n
end

("a".."z").to_a

# Iterating over a range by an increment of 2, using #step (passing each (2nd) element to the block).
(0..10).step(2) do |n|
  puts n
end
# >> 0
# >> 2
# >> 4
# >> 6
# >> 8
# >> 10

# Without a block, this returns an enumerator.
(0..10).step(2).to_a
# => [0, 2, 4, 6, 8, 10]
