@names = %w[Ylva Brighid Shifra Yesamin]

def names
  yield @names.shift # shift returns the first element of self and removes it.
  yield @names.shift
  yield @names.shift
  yield @names.shift
end

enum = to_enum(:names)
@names = %w[Kashti Aodhan Edgar Heinlein]
enum.rewind
enum.next
# we can drive the method's execution forward as needed by calling #next on the Enumerator.

enum.with_index do |name, index|
  puts "#{index}: #{name}"
end
# An Enumerator takes any method that yields values to a block, and turns it into a lazy, iterable object
# which supports all the convenient methods of Enumerable.
