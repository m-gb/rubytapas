   text = <<END
I'm your only friend
I'm not your only friend
But I'm a little glowing friend
But really I'm not actually your friend
But I am
END

word_count = Hash.new do |hash, missing_key|
  hash[missing_key] = 0
end

text.split.map(&:downcase).each do |word|
  word_count[word] += 1
end
word_count

h = Hash.new { |h, k| h[k] = [] } # !> shadowing outer local variable - h
h["IPAs"] << "Victory HopDevil"
h["IPAs"] << "Weyerbacher Double Simcoe"
h["Stouts"] << "Victory Storm King"
h["Stouts"]
# => ["Victory Storm King"]
# Hash uses the same default object everywhere. It doesn't duplicate it before use.
# when we use a default block instead of a default value, the block is executed every time a default value is needed,
# thus generating a new Array object every time.
