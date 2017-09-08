# This gives us a Proc object, which we can then assign to variables and pass around.
# When we want the code to execute, we send it the #call method.
greeter = Proc.new do |name|
  puts "Hello, #{name}"
end
greeter                       # => #<Proc:0x0000000410cd00@-:1>
greeter.call("Ylva")
# >> Hello, Ylva
greeter["Kashti"]
greeter.("Josh")

# the lambda version adds the word “lambda” when inspected. They both execute when called.
# One difference is that the lambda version is pickier about arguments.
# The basic Proc just throws away extra arguments, whereas the lambda version reports an error.
greeter_p = proc do |name|
  puts "Hello, #{name}"
end
greeter_l = lambda do |name|
  puts "Hello, #{name}"
end

greeter_p                       # => #<Proc:0x0000000338efe8@-:1>
greeter_l                       # => #<Proc:0x0000000338efc0@-:4 (lambda)>
greeter_p.call("Lily")
greeter_l.call("Stacey")

# There is also an extra short form for writing lambdas, which is sometimes referred to as “stabby lambda” syntax.
# method-style parentheses, instead of vertical pipes.
greeter_l = ->(name) {
  puts "Hello, #{name}"
}

greeter_l                       # => #<Proc:0x000000031fba50@-:1 (lambda)>

#Every Ruby method can implicitly receive a proc argument, which is called using the yield keyword.
def each_child
  yield "Lily"
  yield "Josh"
  yield "Kashti"
  yield "Ebba"
  yield "Ylva"
end

each_child do |name|
  puts "Hello, #{name}!"
end
# >> Hello, Lily!
# >> Hello, Josh!
# >> Hello, Kashti!
# >> Hello, Ebba!
# >> Hello, Ylva!
