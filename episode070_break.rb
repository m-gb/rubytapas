def names
  yield "Ylva"
  yield "Brighid"
  yield "Shifra"
  yield "Yesamin"
ensure
  puts "Grimm"
end

names do |name|
  puts name
  break if name =~ /^S/
end

# Ylva
# Brighid
# Shifra
# Grimm

# break is not just for loops and iteration. It can force an early return from any method that yields.
# While break can end a method's execution early, it still respects ensure blocks.
