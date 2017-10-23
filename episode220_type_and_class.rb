# in the absence of differing behavior, differentiated child classes aren't needed.
# transition to using different instances to represent different units, instead of different classes.

class Quantity
	attr_reader :magnitude, :unit

	def initialize(magnitude, unit)
		@magnitude = magnitude.to_f
		@unit      = unit
		freeze
	end
		
	def to_s
		"#{@magnitude} #{unit}"
	end


	def inspect
		"#<#{unit}:#{@magnitude}>"
	end

	def +(other)
		other = ensure_compatible(other) 
		self.class.new(@magnitude + other.to_f, unit)
	end

	def -(other)
		other = ensure_compatible(other) 
		self.class.new(@magnitude - other.to_f, unit)
	end

	def *(other)
		multiplicand = if other.is_a?(Numeric)
										other
									elsif other.is_a?(Quantity) && other.unit == unit
										other.to_f
									else
										fail TypeError, "Don't know how to multiply by #{other}"
									end
		self.class.new(@magnitude * multiplicand, unit)
	end

	def <=>(other)
		return nil unless other.is_a?(self.class) && other.unit == unit
		magnitude <=> other.to_f
	end

	def Feet(value)
		if value.is_a?(Quantity) && value.unit == :feet
			value
		else
			value = Float(value)
			Quantity.new(value, :feet)
		end
	end

	def Meters(value)
		if value.is_a?(Quantity) && value.unit == :meters
			value
		else
			value = Float(value)
			Quantity.new(value, :meters)
		end
	end

end

ConversionRatio.registry << 
ConversionRatio.new(:feet, :meters, 0.3048) <<
ConversionRatio.new(:meters, :feet, 3.28084)

# So long as some kind of object may have different sub-types, and those types affect the logic of a program,
# we need a way of representing that differentiation. The Ruby way to encode type is with a class (or module).