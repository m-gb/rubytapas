
puts "__FILE__: #{__FILE__}"
puts "expand_path: #{File.expand_path("..", __FILE__)}"
puts "__dir__: #{__dir__}"

# Moving the file to a subdirectory and then running it:

$ mkdir foo
$ mv whereami.rb foo
$ ruby foo/whereami.rb
__FILE__: foo/whereami.rb
expand_path: /home/avdi/Dropbox/rubytapas/245-current-dir/foo
__dir__: /home/avdi/Dropbox/rubytapas/245-current-dir/foo


# Evaluating from inside another Ruby program:
# The expand_path version winds up showing the current working directory, rather than the location of the source file.
# __dir__ has a nil value when Ruby doesn't know what file the current code is from.

eval File.read("foo/whereami.rb")
# >> __FILE__: (eval)
# >> expand_path: /home/avdi/Dropbox/rubytapas/245-current-dir
# >> __dir__:

# __dir__ is more honest, while the expand_path version is misleading.