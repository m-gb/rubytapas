# This line now does three things: it reads up to 1k of the file.
# Then it assigns the resulting string (or nil value) to the chunk variable.
book = open('../../books/confident-ruby/confident-ruby.org')
lines = 0
while chunk = book.read(1024)
  lines += chunk.count("\n")
end
puts lines
# the use of the chunk variable is neatly contained within the loop it pertains to.
# If we were to ever remove the loop, we wouldn't be leaving a dangling variable behind.

# A convention that some Ruby programmers use to avoid this confusion is to always
# surround loop conditions containing inline assignment with a set of parentheses.
while(chunk = book.read(1024))
  lines += chunk.count("\n")
end

# inline assignment in tests:
class SiteVisit
  attr_reader :timestamp
  def initialize
    @timestamp = Time.now
  end
end
# require 'rspec/autorun'
# describe SiteVisit do
#   it 'sets timestamp to the current time' do
#     expected_time = Time.new(2013, 1, 1)
#     Time.stub(now: expected_time)
#     visit = SiteVisit.new
#     visit.timestamp.should eq(expected_time)
#   end
# end
# We can save some typing in this test by inlining the assignment of the expected_time into the definition of the Time.now stub:
require 'rspec/autorun'
describe SiteVisit do
  it 'sets timestamp to the current time' do
    Time.stub(now: expected_time = Time.new(2013, 1, 1))
    visit = SiteVisit.new
    visit.timestamp.should eq(expected_time)
  end
end
# for quickly naming the return value of one stubbed method, this idiom is convenient.
