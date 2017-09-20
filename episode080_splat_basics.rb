a1 = [:first, :second, :third, :fourth]
a2 = [:before, a1, :after]
a2.flatten
# => [:before, :first, :second, :third, :fourth, :after]
a2 = [:before, *a1, :after]
# => [:before, :first, :second, :third, :fourth, :after]

# We prefix a1 with an asterisk, telling Ruby to “splat it out” into its component elements rather than inserting the array object.
a1 = [:first, :second, :third, :fourth]
x, y, z = *a1
x                               # => :first
y                               # => :second
z                               # => :third

a1 = [:first, :second, :third, :fourth]
*x, y, z = *a1
x                               # => [:first, :second]
y                               # => :third
z                               # => :fourth

a1 = [:first, :second, :third, :fourth]
first, *rest = *a1

first                           # => :first
rest                            # => [:second, :third, :fourth]
# with methods:
def sum3(x, y, z)
  x + y + z
end

triangle = [90, 30, 60]
sum3(*triangle)                 # => 180

def random_draw(num_times, num_draws)
  num_times.times do
    draws = num_draws.times.map { rand(10) }
    yield(*draws)
  end
end

random_draw(5, 3) do |first, second, third| # five times, 3 numbers.
  puts "#{first} #{second} #{third}"
end
# >> 9 5 3
# >> 3 8 1
# >> 4 7 6
# >> 2 1 3
# >> 8 3 3

# By applying a splat to the last parameter, we force it to “soak up” all remaining arguments (if any) into a new array.
def random_draw(num_times, num_draws)
  num_times.times do
    draws = num_draws.times.map { rand(10) }
    yield(*draws)
  end
end

random_draw(5, 3) do |first, *rest|
  puts "#{first}; #{rest.inspect}"
end
# >> 7; [7, 0]
# >> 6; [6, 9]
# >> 6; [6, 2]
# >> 2; [2, 3]
# >> 3; [2, 2]
