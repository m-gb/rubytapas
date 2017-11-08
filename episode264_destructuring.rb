# Destructuring assignment is the process of assigning multiple variables at one time.
arr = [2, 3]
(a, b) = *arr
a # => 2
b # => 3

dep = {"hello" => ["hello.c", "foo.o", "bar.o"]} 
# The first file in the dependency is the primary source file. The others are supporting libraries.

# Breaking out the parts of this dependency by assigning one piece at a time:
dep.first                          # => ["hello", ["hello.c", "foo.o", "bar.o"]] # Individual hash entries are represented as two element arrays.
target = dep.first.first        # => "hello"
first_preq = dep.first.last.first # => "hello.c"
rest_preqs = dep.first.last[1..-1] # => ["foo.o", "bar.o"]

# A different approach:

dep = {"hello" => ["hello.c", "foo.o", "bar.o"]}

a = *dep                        # => [["hello", ["hello.c", "foo.o", "bar.o"]]] # We splat out the dependency into an array.

((target, (first_preq, *rest_preqs))) = *dep

target                          # => "hello"
first_preq                      # => "hello.c"
rest_preqs                      # => ["foo.o", "bar.o"]
