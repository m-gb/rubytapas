point = Struct.new(:x, :y)
point # => #<Class:0x00000004da22e0>
point.class # => Class
point.name  # => nil

Point = point
Point # => Point
point # => Point
point.class # => Class
point.name  # => "Point"  #Ruby sets the name of the class or module to the name of the constant. 

Point = Struct.new(:x, :y)
Point.new                       # => #<struct Point x=nil, y=nil>
Point.new(23)                   # => #<struct Point x=23, y=nil>
Point.new(5,7)

p = Point.new(4,5)
p[:x]                           # => 4
p["y"]                          # => 5
p[:x] = 13
p.x                             # => 13
