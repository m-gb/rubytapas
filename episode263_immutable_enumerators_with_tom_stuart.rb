# The string 'cherry' is being modified in-place by the #print_pie method.
def print_pie(filling)
  puts filling << ' pie'
end

fruit = 'cherry'
print_pie(fruit)
fruit # => "cherry pie"

# We can clone it and pass the clone around instead.
fruit = 'cherry'
cloned_fruit = fruit.clone
print_pie(cloned_fruit)
fruit # => "cherry" # The original value remains unchanged.

# Freezing the value, getting an exception if we try to modify it:
fruit = 'cherry'
frozen_fruit = fruit.freeze
print_pie(frozen_fruit)
fruit # =>
# ~> -:2:in `print_pie': can't modify frozen String (RuntimeError)
# ~>  from -:7:in `<main>'

# The simplest way to make an immutable collection is to call #freeze on an existing array:
fruits = %w(apple banana cherry damson elderberry)
fruits.freeze
fruits << 'fig' # =>
# ~> -:3:in `<main>': can't modify frozen Array (RuntimeError)

# A naturally immutable collection, using the #to_enum method to make an immutable collection:
fruits = %w(apple banana cherry damson elderberry).to_enum # enum lets us iterate over the underlying collection, but not modify it.
fruits.entries # => ["apple", "banana", "cherry", "damson", "elderberry"]
fruits << 'fig' # =>
# ~> -:3:in `<main>': undefined method `<<' for #<Enumerator> (NoMethodError)

# Making an enum from scratch:
fruits = Enumerator.new do |yielder|
  yielder.yield 'apple'
  yielder.yield 'banana'
  yielder.yield 'cherry'
  yielder.yield 'damson'
  yielder.yield 'elderberry'
end
fruits.entries # => ["apple", "banana", "cherry", "damson", "elderberry"]

# Creating a new collection by changing the contents of the initial one:
fruits.class # => Enumerator
fruits.map(&:upcase) # => ["APPLE", "BANANA", "CHERRY", "DAMSON", "ELDERBERRY"] # => Array
fruits.select { |fruit| fruit.length == 6 } # => ["banana", "cherry", "damson"] # => Array

# Adding an element:
more_fruits = Enumerator.new do |yielder| # Making a modified copy of an immutable collection.
  fruits.each do |fruit|
    yielder.yield fruit
  end

  yielder.yield 'fig'
end
more_fruits.entries # => ["apple", "banana", "cherry", "damson", "elderberry"]
fruits.include?('fig') # => false
more_fruits.include?('fig') # => true

# Removing an element:
fewer_fruits = Enumerator.new do |yielder|
  fruits.each do |fruit|
    yielder.yield fruit unless fruit == 'cherry'
  end
end
fewer_fruits.entries # => ["apple", "banana", "damson", "elderberry"]
fruits.include?('cherry') # => true
fewer_fruits.include?('cherry') # => false

# An infinite collection of even numbers:
even_numbers = Enumerator.new do |yielder|
  n = 2

  loop do
    yielder.yield n
    n += 2
  end
end
even_numbers.next # => 2
even_numbers.next # => 4

even_numbers.take 10 # => [2, 4, 6, 8, 10, 12, 14, 16, 18, 20] # The enum generates more elements as they're needed.

even_or_unlucky_numbers = Enumerator.new do |yielder|
  even_numbers.each do |n|
    yielder.yield n
    yielder.yield 13 if n == 12
  end
end
even_or_unlucky_numbers.take 10 # => [2, 4, 6, 8, 10, 12, 13, 14, 16, 18]

# With cloning and freezing an Array, we can still modify the string objects it contains:
fruits = %w(apple banana cherry damson elderberry)
cloned_fruits = fruits.clone # Same with #freeze.
cloned_fruits.first.prepend 'pine'
fruits # => ["pineapple", "banana", "cherry", "damson", "elderberry"]

# An enum is regenerated every time we iterate over it:
fruits = Enumerator.new do |yielder|
  yielder.yield 'apple'
  yielder.yield 'banana'
  yielder.yield 'cherry'
  yielder.yield 'damson'
  yielder.yield 'elderberry'
end

fruits.first.prepend 'pine'
fruits.entries # => ["apple", "banana", "cherry", "damson", "elderberry"]