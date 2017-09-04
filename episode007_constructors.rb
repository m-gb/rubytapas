class Point1
  def self.my_new(*args, &block)
    instance = allocate
    instance.my_initialize(*args, &block)
    instance
  end

  def my_initialize(x,y)
    @x = x
    @y = y
  end
end

p = Point1.my_new(3,5)

class Point2
  def self.new_cartesian(x, y)
    instance = allocate
    instance.initialize_cartesian(x, y)
    instance
  end

  def self.new_polar(distance, angle)
    instance = allocate
    instance.initialize_cartesian(polar_to_cartesian(distance, angle))
    instance
  end
  # ...
end

class Snowflake
  class << self
    private :new
  end

  def self.instance
    @instance ||= new
  end
end

Snowflake.instance # => #<Snowflake:0x00000004af4db8>
Snowflake.instance # => #<Snowflake:0x00000004af4db8>

Snowflake.new # =>
# ~> -:14:in `<main>': private method `new' called for Snowflake:Class (NoMethodError)

class RpsMove
 def self.new(move)
   @cache ||= {}
   @cache[move] ||= super(move)
 end

 def initialize(move)
   @move = move
 end
end

RpsMove.new(:rock) # => #<RpsMove:0x00000004967428 @move=:rock>
RpsMove.new(:rock) # => #<RpsMove:0x00000004967428 @move=:rock>
