class Feet; end
class Meters; end

ConversionRatio = Struct.new(:from, :to, :number) do
  def self.registry
    @registry ||= []
  end

  def self.find(from, to)
    registry.detect{|ratio| ratio.from == from && ratio.to == to}
  end
end

ConversionRatio.registry << 
  ConversionRatio.new(Feet, Meters, 0.3048) <<
  ConversionRatio.new(Meters, Feet, 3.28084)

def convert_to(target_type)
  ratio = ConversionRatio.find(self.class, target_type) or    # asking, not telling.
    fail TypeError, "Can't convert #{self.class} to #{target_type}"
  target_type.new(magnitude * ratio.number)
end

# we should tell objects what to do, rather than asking them about themselves.
class Feet; end
class Meters; end

UnitConversion = Struct.new(:from, :to) do
  def self.registry
    @registry ||= []
  end

  def self.find(from, to)
    registry.detect{|ratio| ratio.from == from && ratio.to == to}
  end

  def call(from_value) # expected to be implemented in derived classes.
    raise NotImplementedError
  end
end

class RatioConversion < UnitConversion # adds a number and overrides #call.
  attr_reader :number
  def initialize(from, to, number)
    super(from, to)
    @number = number
  end

  def call(from_value)
    from_value * number
  end
end

UnitConversion.registry << 
  RatioConversion.new(Feet, Meters, 0.3048) <<
  RatioConversion.new(Meters, Feet, 3.28084)


def convert_to(target_type)
  conversion = UnitConversion.find(self.class, target_type) or 
    fail TypeError, "Can't convert #{self.class} to #{target_type}"
  target_type.new(conversion.call(magnitude)) # instead of reaching into the resulting object, it simply tells that object to perform its conversion.
end
# Now that we've switched from asking to telling, we easily add code to deal with temperature conversions.
require "./conversion"

class Celsius; end
class Fahrenheit; end

class BlockConversion < UnitConversion
  def initialize(from, to, &block)
    super(from, to)
    @block = block
  end

  def call(from_value)
    @block.call(from_value)
  end
end

UnitConversion.registry << BlockConversion.new(Celsius, Fahrenheit) { 
  |from_value|
  ((from_value * 9) / 5) + 32
}

UnitConversion.find(Celsius, Fahrenheit).call(32)
# => 89
