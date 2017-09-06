def greet(params)
  name = user_name(params) rescue "Anonymous"
  puts "Hello, #{name}"
end
#if the username is missing; we'd like to just replace it with a placeholder and keep going.

greet({})
# >> Hello, Anonymous

#if we want to examine the exception before deciding to re-raise itץ
value_or_error = {}.fetch(:some_key) rescue $! #a reference to the currently-raised exception
value_or_error # => #<KeyError: key not found: :some_key>

#rescue is an excellent way to convert exceptions into return values.
