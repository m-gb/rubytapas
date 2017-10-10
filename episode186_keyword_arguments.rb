# We use the Hash#fetch method to get the value or provide a default if it is not present.
def order_burger(customer_name, options={})
has_cheese = options.fetch(:cheese)  # This line will raise a KeyError if no :cheese option is specified. 
toppings = []
toppings << :onions if options.fetch(:onions) { true }
toppings << :bacon  if options.fetch(:bacon)  { false  }
patty_type = options.fetch(:patty)  { :beef }

print "That's one #{patty_type} #{has_cheese && "cheese"}burger"
print " with #{toppings.join(', ')}"
print " for #{customer_name}.\n"
end

order_burger("Grimm", cheese: true, bacon: true, onions: false)
# >> That's one beef cheeseburger with bacon for Grimm.
# Ruby lets us omit the braces around a Hash argument if it's the last argument passed to a method. keyword-style arguments.

def order_burger(customer_name, options={})
patty_type = options.delete(:patty)  { :beef } # checks that only known options are specified.
has_cheese = options.delete(:cheese)
toppings = []
toppings << :onions if options.delete(:onions) { true }
toppings << :bacon  if options.delete(:bacon)  { false  }
if options.any?                                             # checks if there are any options left in the hash.    
  raise ArgumentError, "Unrecognized option(s): #{options}"
end

print "That's one #{patty_type} #{has_cheese && "cheese"}burger"
print " with #{toppings.join(', ')}"
print " for #{customer_name}.\n"
end

order_burger("Grimm", cheese: true, bacon: true, onion: false)
# ~> -:8:in `order_burger': Unrecognized option(s): {:onion=>false} (ArgumentError)

# the cheese keyword is a required option, so we don't supply a default for it. 
def order_burger(customer_name, patty: :beef, cheese:, onions: true, bacon: false)
  toppings = []
  toppings << :onions if onions
  toppings << :bacon  if bacon
 
  print "That's one #{patty} #{cheese ? "cheese" : ""}burger"
  print " with #{toppings.join(', ')}"
  print " for #{customer_name}.\n"
end

# With just a “cheese” option, it supplies the defaults for patty type and toppings. 
order_burger("Grimm", cheese: true)
# >> That's one beef cheeseburger with onions for Grimm.