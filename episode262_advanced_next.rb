# Returning a special string whenever the input is blank, using next:
# The argument to next becomes the return value of the current invocation of a block(instead of nil).

objects = ["house", "mouse", "", "mush", "",
"little old lady whispering 'hush'"]

result = objects.map do |o|
next "Goodnight, Moon" if o.empty? # supplying an argument to next.
"Goodnight, #{o}"
end
result.compact
# => ["Goodnight, house",
#     "Goodnight, mouse",
#     "Goodnight, Moon",
#     "Goodnight, mush",
#     "Goodnight, Moon",
#     "Goodnight, little old lady whispering 'hush'"]

# A long list of filenames. We want to get all of our rules for inclusion or exclusion in one place.
# To do that, we use a series of next statements.

Dir["../**/*.mp4"].select { |f|
next false unless File.file?(f) # we skip the remaining checks using next with a false argument and it'll return false. 
next false unless File.readable?(f) # skips forward if the file isn't readable.
next true if f =~ /078b-java-dregs\.mp4/ # next with a true argument skips all remaining tests and tells #select to include this entry in the results.
next false if File.size(f) == 0
next true if File.basename(f) =~ /^\d\d\d-/ # includes files matching a particular naming scheme.
}

# A method that accepts a block. It yields to the block twice, logging before and after each yield.

def yieldtwice
  puts "Before first yield"
  yield
  puts "Before second yield"
  yield
  puts "After last yield"
end

yieldtwice do
  puts "About to invoke next"
  next                         # This behaves like an early return, except for a block instead of a method.  
  puts "Can never get here"
end
puts "After method call"

# >> Before first yield
# >> About to invoke next
# >> Before second yield
# >> About to invoke next
# >> After last yield
# >> After method call

# Using break instead of next:

def yieldtwice
  puts "Before first yield"
  yield
  puts "Before second yield"
  yield
  puts "After last yield"
end

yieldtwice do
  puts "About to invoke break"
  break
  puts "Can never get here"
end
puts "After method call"

# >> Before first yield
# >> About to invoke break
# >> After method call

# Unlike next, break doesn't just bring a yield to an early end. 
# It cancels the execution of the whole method that triggered the yield.