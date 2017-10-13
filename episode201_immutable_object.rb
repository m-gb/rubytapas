# Numbers are immutable: they cannot be changed. 
class Feet
  attr_accessor :magnitude

  def initialize(magnitude)
    @magnitude = magnitude.to_f
  end

  def to_s
    "#{@magnitude} feet"
  end

  def +(other)
    Feet.new(@magnitude + other.magnitude)
  end
end

class Altimeter
  def initialize(value)
    raise TypeError unless Feet === value
    @value_in_feet = value
  end

  def change_by(change_amount)
    raise TypeError unless Feet === change_amount
    old_value = @value_in_feet
    @value_in_feet.magnitude += change_amount.magnitude  # the Feet class is mutable.
    puts "Altitude changed from #{old_value} to #{@value_in_feet}"
  end
end

require "./feet"
require "./altimeter2"

START_ALTITUDE = Feet.new(10_000) # holds a default starting altitude.

alt = Altimeter.new(START_ALTITUDE)
alt.change_by(Feet.new(500))

START_ALTITUDE                  # => #<Feet:0x000000017e0e90 @magnitude=10500.0>
# >> Altitude changed from 10500.0 feet to 10500.0 feet      unwanted behavior, the constant's value has changed.

# Making the Feet class immutable:
class Feet
  attr_reader :magnitude             #
 
  def initialize(magnitude)
    @magnitude = magnitude.to_f
    freeze                           # This tells ruby to make the object immutable.
  end
 
  def to_s
    "#{@magnitude} feet"
  end
 
  def +(other)
    Feet.new(@magnitude + other.magnitude)
  end

  def positive?  # leaving a method which unintentionally updates the value in-place whenever it is called.
    @magnitude = 0.0
  end
end

f = Feet.new(30_000)
f.positive?                     # => 
# ~> -:18:in `positive?': can't modify frozen Feet (RuntimeError)
# ~>    from -:23:in `<main>'

# We now have a class which ensures that we can't circumvent immutability, even accidentally.