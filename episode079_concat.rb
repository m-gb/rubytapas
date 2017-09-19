class Shopper
  def initialize(list)
    @list = list
  end

  attr_accessor :list
end

shared_list = ["bread", "milk", "granola"]
stacey = Shopper.new(shared_list)
avdi   = Shopper.new(shared_list)
stacey.list.concat(["swiss", "brie", "cheddar"])
stacey.list                     # => ["bread", "milk", "granola", "swiss", "brie", "cheddar"]
avdi.list                       # => ["bread", "milk", "granola", "swiss", "brie", "cheddar"]


# When we send the message #concat to the shared list, with the array of new items as an argument, the target array is updated in-place.
# We get the behavior we expect, with both shopper attributes reflecting the new contents.
# Unless you specifically want to create a new combined array rather than append to an existing one, prefer Array#concat over +=.
