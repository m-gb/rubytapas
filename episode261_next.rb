objects = ["house", "mouse", "", "mush", "",
"little old lady whispering 'hush'"]

objects.each do |o|
puts "Goodnight, #{o}"
end
# >> Goodnight, house
# >> Goodnight, mouse
# >> Goodnight,
# >> Goodnight, mush
# >> Goodnight,
# >> Goodnight, little old lady whispering 'hush'

# A conditional statement around the puts:

objects.each do |o|
unless o.empty?
puts "Goodnight, #{o}"
end
end
# >> Goodnight, house
# >> Goodnight, mouse
# >> Goodnight, mush
# >> Goodnight, little old lady whispering 'hush'

# Using the next keyword to tell Ruby to skip to the next iteration:

objects.each do |o|
next if o.empty?
puts "Goodnight, #{o}"
end
# >> Goodnight, house
# >> Goodnight, mouse
# >> Goodnight, mush
# >> Goodnight, little old lady whispering 'hush'

# next skips to the next iteration, whereas break breaks completely out of the method
# that the block has been passed into (in this case: each).


# As a variable, using map and without next: 

objects = ["house", "mouse", "", "mush", "",
"little old lady whispering 'hush'"]

result = objects.map do |o|
"Goodnight, #{o}"
end

# an array of strings
result 
# => ["Goodnight, house",
#     "Goodnight, mouse",
#     "Goodnight, ",
#     "Goodnight, mush",
#     "Goodnight, ",
#     "Goodnight, little old lady whispering 'hush'"]

# Using next:

result = objects.map do |o|
next if o.empty?
"Goodnight, #{o}"
end

result
# => ["Goodnight, house",
#     "Goodnight, mouse",
#     nil,
#     "Goodnight, mush",
#     nil,
#     "Goodnight, little old lady whispering 'hush'"]

# We now know that the return value of a block invocation which is skipped by next is nil.
# Using compact to filter out all the nil entries:

result = objects.map do |o|
next if o.empty?
"Goodnight, #{o}"
end

result.compact
# => ["Goodnight, house",
#     "Goodnight, mouse",
#     "Goodnight, mush",
#     "Goodnight, little old lady whispering 'hush'"]