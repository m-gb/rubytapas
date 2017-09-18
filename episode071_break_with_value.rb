def names
  yield "Ylva"
  yield "Brighid"
  yield "Shifra"
  yield "Yesamin"
end

# break can take an optional argument.
result = names do |name|
  puts name
  break name if name =~ /^S/
end
result
# Shifra
# by passing the matching name to break, we forced the names method to return that string instead of a nil.


f = open('071-break-with-value.org')
f.lines.detect do |line|
  if f.lineno >= 100
    break "<Not Found (Stopped at #{f.lineno}: '#{line.chomp}')>"
  end
  line =~ /banana/
end
# break can not only force a method to return early, it can also override the return value of the method in the process. 
