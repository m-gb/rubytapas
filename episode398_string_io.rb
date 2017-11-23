# The IO class is the basis for all input and output in Ruby.
# An IO object is effectively a wrapper around the operating systems concept of a filehandle.
# Like the File class, the Socket library subclasses from IO (such as TCPSocket or UDPSocket).

open("/dev/urandom")            # => #<File:/dev/urandom>
File.superclass                 # => IO

require "socket"

TCPSocket.new "google.com", 80
# => #<TCPSocket:fd 7>

TCPSocket.ancestors
# => [TCPSocket, IPSocket, BasicSocket, IO, File::Constants, Enumerable, Object, JSON::Ext::Generator::GeneratorMethods::Object, Kernel, BasicObject]

# Tempfile is what is known as an IO-like object.

require "tempfile"

temp = Tempfile.new                    # => #<Tempfile:/tmp/20160316-13069-134v9lj>
temp.write "Hello"
temp.close
temp.open
temp.read                       # => "Hello"

Tempfile.ancestors
# => [Tempfile, #<Class:0x0055cfc0f224d0>, Delegator, #<Module:0x0055cfc117fe08>, BasicObject]
