# The __FILE__ variable always contains the absolute path of the file it is found in.
# The first argument to File.expand_path is the path to be expanded, and the second is the base path to start from. 
__FILE__
# => /myapp/bin/hello
 
File.expand_path "..", __FILE__
# => /myapp/bin
 
File.expand_path "../..", __FILE__
# => /myapp
 
File.expand_path "../../cow_helpers", __FILE__
# => /myapp/cow_helpers
 
require File.expand_path("../../cow_helpers", __FILE__)
 
print CowHelpers.moo "Hello, world"