require 'open-uri'
require 'json'

def get_observation
  key  = ENV['WUNDERGROUND_KEY']
  url  = "http://api.wunderground.com/api/#{key}/conditions/q/PA/York.json"
  data = open(url).read
  JSON.parse(data)['current_observation']
end

def print_observation(observation)
  puts "Temperature: #{observation.temp_f}F"
  pressure_trend = observation.pressure_trend == "-" ? "falling" : "rising"
  puts "Pressure: #{observation.pressure_mb}mb and #{pressure_trend}"
  puts "Winds: #{observation.wind_string}"
end

require 'ostruct'
observation = {
  'temp_f'         => 49.0,
  'pressure_trend' => '-',
  'pressure_mb'    => 981,
  'wind_string'    => "From the North at 3.0 MPH Gusting to 7.0 MPH"
}
os = OpenStruct.new(observation) # What we get in return is an object that has a reader method for each key in the hash.
os.temp_f                       # => 49.0
os.wind_string                  # => "From the North at 3.0 MPH Gusting to 7.0 MPH"

print_observation(get_observation)

#differences:
require 'ostruct'
s  = Struct.new(:foo, :bar).new(42, 32)
os = OpenStruct.new(foo: 42, bar: 23)

s.members                       # => [:foo, :bar]
os.members                      # => nil
s.map {|value| value * 2}       # => [84, 64]
os.map {|value| value * 2}      # => nil
