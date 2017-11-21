# A doubled-up bang operator to force a value to be converted to a boolean.

code = <<EOF
bool = !!result
EOF

code.chars.chunk{|c|
  case c
  when /\n/ then :endline
  when /[[:alpha:]]/ then :identifier
  when /[\!\+\-\=\/\*]/ then :operator
  when /\d/ then :number
  end
}.to_a
# => [[:identifier, ["b", "o", "o", "l"]],
#     [:operator, ["="]],
#     [:operator, ["!", "!"]],
#     [:identifier, ["r", "e", "s", "u", "l", "t"]],
#     [:endline, ["\n"]]]

# A doubled-up bang shouldn't be treated as a single operator.
# Instead of "operator" we'll categorize these characters using the flag symbol :_alone.

code = <<EOF
bool = !!result
EOF

code.chars.chunk{|c|
  case c
  when /\n/ then :endline
  when /[[:alpha:]]/ then :identifier
  when /[\!\+\-\=\/\*]/ then :_alone
  when /\d/ then :number
  end
}.to_a
# => [[:identifier, ["b", "o", "o", "l"]],
#     [:_alone, ["="]],
#     [:_alone, ["!"]],
#     [:_alone, ["!"]],
#     [:identifier, ["r", "e", "s", "u", "l", "t"]],
#     [:endline, ["\n"]]]

# Now the operator characters are chunked with the symbol :_alone.

# Receiving input chunks as an array of lines.

require 'stringio'
data = "6\r\nHello!\r\nD\r\n How are\r\n you?\r\n0\r\n"
chunked_data = StringIO.new(data)

chunks = chunked_data
         .each_line("\r\n")
         .chunk({chunk_num: 0, chars_left: :unknown}){
  |line, state|
  line.chomp!("\r\n")
  if state[:chars_left] == :unknown
    state[:chars_left] = Integer(line, 16)
    :_separator
  elsif state[:chars_left] > 0
    state[:chars_left] -= line.size
    state[:chunk_num]
  else
    state[:chunk_num] += 1
    state[:chars_left] = :unknown
    redo
  end
}

chunks.next                     # => [0, ["Hello!"]]
chunks.next                     # => [1, [" How are", " you?"]]
