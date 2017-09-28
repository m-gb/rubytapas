# DateTime.strptime normally takes two arguments: a time string to parse, and a format specification.
# Time.strftime is the method used to convert times into strings. 
require 'date'

print_format = '%-m/%-d/%Y %k:%M'
Time.new(2013, 4, 28, 9, 0).strftime(print_format)
# => "4/28/2013  9:00"

# In order to convert it to a valid strptime format to parse the same style, we only need to remove the padding modifiers from the format.
format = '%m/%d/%Y %k:%M'
DateTime.strptime('4/28/2013 9:00', format).to_time # DateTime.strptime, given no explicit time zone to parse, assumed the time was UTC. 
# => 2013-04-28 05:00:00 -0400

# The sibling method called _strptime returns a hash of time components.
format = '%m/%d/%Y %k:%M'
time_parts = DateTime._strptime('4/28/2013 9:00', format)
# => {:mon=>4, :mday=>28, :year=>2013, :hour=>9, :min=>0}

# We can convert the time string to a locally-zoned Time object by breaking the string up into parts, then feeding them into Time.local: 
format = '%m/%d/%Y %k:%M'
time_parts = DateTime._strptime('4/28/2013 9:00', format)
time = Time.local(
  time_parts[:year],
  time_parts[:mon],
  time_parts[:mday],
  time_parts[:hour],
  time_parts[:min])
time # => 2013-04-28 09:00:00 -0400

# A gem called "chronic" figures out what time string means and gives us a Time object back:
require 'chronic'
 
time = Chronic.parse('4/28/2013 9:00')
time # => 2013-04-28 09:00:00 -0400