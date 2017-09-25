machine rubytapas.com
 login avdi
 password xyzzy
machine example.org
 login marvin
 password plugh

# With a Struct representing a .netrc entry, we can access the username and password through method calls, or using Hash-style notation.
class Netrc
  Entry = Struct.new(:login, :password) # an “entry” is a collection of unique attributes.
end
entry = Netrc::Entry.new('avdi', 'xyzzy') # implicit splatting.
entry.login                     # => "avdi"
entry.password                  # => "xyzzy"
entry[:login]                   # => "avdi"
entry[:password]                # => "xyzzy"
entry[0]                        # => "avdi"
entry[1]                        # => "xyzzy"
# implicit splatting only works on arrays and “array-like” objects.
# alias entry objects' #to_a method to #to_ary. Now, Entry objects can be implicitly splatted out just like arrays.
class Netrc
  Entry = Struct.new(:login, :password) do
    alias_method :to_ary, :to_a
  end
end
entry = Netrc::Entry.new('avdi', 'xyzzy')
login, password = entry
login                           # => "avdi"
password                        # => "xyzzy"
# Now we have a class that really would make a good replacement for the old two-element-array return value.
# it adds new, meaningful accessor methods.
