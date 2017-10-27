# It's not a good idea to load files full of Ruby code more than once if we can avoid it. 
# Where load re-evaluates a file every time it is invoked, require keeps a global list of all the files it has already processed.
# When we require some library in a Ruby program, we don't require a specific filename. We require a feature by name.

require "bigdecimal"            # => true
require "bigdecimal"            # => false # If it has already been loaded, require returns false.

require "bigdecimal" # If we don't require the library first, the result is false.
feature = "bigdecimal"
 
load_path = $LOAD_PATH.dup
if feature[0] == "."
  load_path.unshift(".")
end
globs = load_path.map{|base_dir| # get a set of file glob patterns by mapping over the load path.
  File.expand_path("#{feature}.*", base_dir) # .* appended, which is a file glob pattern that should match any file extension.
}
globs

files = Dir.glob(globs)
# => ["/home/avdi/.rubies/ruby-2.1.2/lib/ruby/2.1.0/x86_64-linux/bigdecimal.so"]
 
library = files.first
 
$LOADED_FEATURES
# => ["enumerator.so",

$LOADED_FEATURES.include?(library)
# => true