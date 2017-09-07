point = Class.new do
  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end
end

circle = Class.new(point) do # inherit from the new class by passing the parent class to Class.new
  attr_reader :radius
  def initialize(x, y, radius)
    super(x,y)
    @radius = radius
  end
end

c1 = circle.new(3,5,10)
# => #<#<Class:0x974c620>:0x974c5a8 @x=3, @y=5, @radius=10>

# when we name a class, we're simply assigning that class to a constant, just as we might assign a number or a string to a constant.
# functionally there's no difference between an all-caps constant and one that's camel-cased.
Point = Class.new do
  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end
end

# using the class keyword is pretty much just a shorthand for creating a new class object and assigning it to a constant.
