def hello(name)
  puts "Hello, #{name}"
end

code = '
  def goodbye(name)
   puts "Goodbye, #{name}"
  end
'

eval code
goodbye("Crow")
# >> Goodbye, Crow

# To load code more portably and robustly, we need some kind of search path of places to look for code.
# it's a global variable named $LOAD_PATH. 

def try_load_file(file) # a helper method named #try_load_file.
  if File.file?(file)
    puts "LOAD #{file}"
    eval File.read(file)
    return true
  else
    return false
  end
end

def load_lib(name) #  It will take a filename as an argument.
  return true if try_load_file(name) # Finds and loads the file in the current directory.

  $LOAD_PATH.each do |dir|  # This global variable is pre-loaded with a number of default system directories.
    file = File.join(dir, name)
    return if try_load_file(file)
  end

  fail LoadError, "Library not found: #{name}"
end

# Loading up our own library files. Expanding the path one level up from the file. 
my_lib_dir = File.expand_path("..", __FILE__)
# => "/home/avdi/Dropbox/rubytapas/235-require"

# $LOAD_PATH << my_lib_dir
$LOAD_PATH.unshift(my_lib_dir) # Prepending to an array.