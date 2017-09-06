class Parent
  def hello(subject="World")
    puts "Hello, #{subject}"
    if block_given?
      yield
      puts "Well, nice seeing you!"
    end
  end
end

class Child < Parent
  def hello(subject=:default)
    if subject == :default
      super(&nil)
      puts "How are you today?"
    else
      super(subject, &nil)
      puts "How are you today?"
    end
  end
end

Child.new.hello(:default) do
  puts "Hi there, Child"
end
 
#In order to suppress the block being passed through, we have to use the special argument &nil.
