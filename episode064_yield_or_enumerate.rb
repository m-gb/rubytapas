require 'pp'
[0,1,2,3,4,5,6,7,8,9].each_slice(2) do |slice|
  pp slice
end
# >> [0, 1]
# >> [2, 3]
# >> [4, 5]
# >> [6, 7]
# >> [8, 9]

# But if we call it without a block, it returns an Enumerator.
# chaining enumerable operations:
require 'pp'
sums = [0,1,2,3,4,5,6,7,8,9].each_slice(2).map do |slice|
 slice.reduce(:+)
end
sums # => [1, 5, 9, 13, 17]

# how to duplicate this behavior in our own methods:
def names
  return to_enum(:names) unless block_given? # return to_enum(__callee__) to ensure that if we ever change the name of the method the call to #to_enum will continue to work.
  yield "Ylva"
  yield "Brighid"
  yield "Shifra"
  yield "Yesamin"
end

names                           # => #<Enumerator: main:names>
names.to_a                      # => ["Ylva", "Brighid", "Shifra", "Yesamin"]
