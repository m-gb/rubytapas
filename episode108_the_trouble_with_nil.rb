# It's the default return value for a Hash when the key is not found:
h = {}
h['fnord']                      # => nil

def empty
  # TODO
end
empty    

result = if (2 + 2) == 5
           "uh-oh"
         end
result                          # => nil

# for a case statement with no matched "when" clauses and no else:
type = case :foo
       when String then "string"
       when Integer then "integer"
       end
type                            # => nil   
 
if (2 + 2) == 5
  tip = "follow the white rabbit"
end
 
tip                             # => nil
 
# unset instance variables (f.e. typos):
@i_can_has_spelling = true
puts @i_can_haz_speling         # => nil

# many ruby methods return nil to indicate failure:
[1, 2, 3].detect{|n| n == 5}    # => nil


# Here's a method for fetching a password. When we call it, returns nil.
require 'yaml'
SECRETS = File.exist?('secrets.yml') && YAML.load_file('secrets.yml')
 
def get_password_for_user(username=ENV['USER'])
  secrets = SECRETS || @secrets
  entry = secrets && secrets.detect{|entry| entry['user'] == username}
  entry && entry['password']
end
 
get_password_for_user        # => nil

# And this is the fundamental problem with nil: it can mean many different things, but the meaning is always contextual.