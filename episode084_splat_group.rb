expr = [:*, 3, [:+, 2, 5]]
op, f1, f2 = expr
inner_op, t1, t2 = f2
 
op                              # => :*
f1                              # => 3
inner_op                        # => :+
t1                              # => 2
t2                              # => 5

# By “grouping” arguments on the left side of the assignment, we can tell Ruby to assign elements of nested arrays directly to variables names. 
expr = [:*, 3, [:+, 2, 5]]
op, f1, (inner_op, t1, t2) = expr
 
op                              # => :*
f1                              # => 3
inner_op                        # => :+
t1                              # => 2
t2                              # => 5

# the inner addition expression has three terms. Instead of providing a variable for each term, we slurp them all up into a variable named ts. 
expr = [:*, 3, [:+, 2, 5, 7]]
op, f1, (inner_op, *ts) = expr
 
op                              # => :*
f1                              # => 3
inner_op                        # => :+
ts                              # => [2, 5, 7]    

# splatting all of the arguments into a single array and then inspecting that array:
menu = { 
  'Jacked Up Turkey'     => '$7.25',
  'New York Mikey'       => '$7.25',
  'Apple Grilled Cheese' => '$5.25' 
}
 
menu.each_with_index do |*args|
  puts args.inspect
end
# >> [["Jacked Up Turkey", "$7.25"], 0]
# >> [["New York Mikey", "$7.25"], 1]
# >> [["Apple Grilled Cheese", "$5.25"], 2]

# using an intermediate variable(the pair argument):
menu = { 
  'Jacked Up Turkey'     => '$7.25',
  'New York Mikey'       => '$7.25',
  'Apple Grilled Cheese' => '$5.25' 
}
 
menu.each_with_index do |pair, i|
  name, price = pair
  puts "#{i+1}: #{name} (#{price})"
end
# >> 1: Jacked Up Turkey ($7.25)
# >> 2: New York Mikey ($7.25)
# >> 3: Apple Grilled Cheese ($5.25

# any syntax we can use on the left side of an assignment, we can also use in an argument list. 
# Instead of an intermediate pair argument, let's put a group in the block argument list:
menu = { 
  'Jacked Up Turkey'     => '$7.25',
  'New York Mikey'       => '$7.25',
  'Apple Grilled Cheese' => '$5.25' 
}
 
menu.each_with_index do |(name, price), i|
  puts "#{i+1}: #{name} (#{price})"
end
# >> 1: Jacked Up Turkey ($7.25)
# >> 2: New York Mikey ($7.25)
# >> 3: Apple Grilled Cheese ($5.25)
 
# As a result we no longer have any need of an intermediate pair variable which exists only to be broken up. 