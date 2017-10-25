# Our deprecation warnings shouldn't be going to standard output; they should be going to the standard error stream.
def old_and_busted
  $stderr.puts "#old_and_busted is deprecated. Use #new_hotness instead." # sending the puts message to the $stderr global.
  puts "Hello, world"
end

def new_hotness
  puts "Salutations, universe!"
end
# The warn method is like puts, only instead of defaulting to standard output, it uses $stderr.
def old_and_busted
  warn "#old_and_busted is deprecated. Use #new_hotness instead."
  puts "Hello, world"
end