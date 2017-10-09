# We want to update the author with pen-name information from each of the stories. 
# when we follow the author association back from one of the stories,
# we get a different object than the author object we started with—the one we are saving back to the database.

author = AM.find(1)
update_pen_names(author)
AM.store(author)
AM.find(1).pen_names
# => nil

author.object_id                              # => 22795980
author.stories.first.author.__get__.object_id # => 22747020

# An identity map ensures that only one object corresponds to a given record in the database at a time.
ID_MAP = {}
AM = AuthorMapper.new(ID_MAP)
SM = StoryMapper.new(ID_MAP)

# 
class TeenyMapper
    # ...
    def initialize(id_map)
      @id_map = id_map
    end
  
    def store(object)
      data  = object.to_h
      store_row(object.class, data)
      object.id = data[:id]
      @id_map[[object.class, object.id]] = object #updates the identity map.
    end
  
    # ...
    #fetch returns a value from the hash for the given key.
    #Using an array as a Hash key shows off the fact that Ruby Hashes can accept any kind of object as a key.
    def load(type, data)
      @id_map.fetch([type, data[:id]]) do  # we use an array of object type and ID as the key.If the identity map already contains an object matching that key, it will be returned immediately.
        object = type.new #Otherwise, a new model object will be constructed, and added to the ID map before it is returned.
        data.each_with_object(object) { |(key, value), o|   
          o[key] = value
        }
        @id_map[type, object.id] = object
      end
    end
  end
  
author = AM.find(1)
author.object_id                              # => 15423800
author.stories.first.author.__get__.object_id # => 15423800
author = AM.find(1)
update_pen_names(author)
AM.store(author)
AM.find(1).pen_names
# => "Anson Macdonald, Lyle Monroe, Caleb Saunders"

# we could set things up so that the identity map also functions as a cache,
# avoiding repeated database requests for objects which have already been loaded once.
before do
  RubyTapas.clear_id_map
  RubyTapas.base_url = Addressable::URI.parse(request.url).site.to_s
  self.current_user = load_user
end