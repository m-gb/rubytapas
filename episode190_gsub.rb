# String#gsub takes a pattern and a replacement string.

TEXT = <<EOF
Since the early 1950s, United States officials have been in contact
with extraterrestrial life forms. Our first contact came after a group
of Grey aliens crash-landed near Roswell, New Mexico. Through them we
learned of the imminent threat of invasion by lizard people from
Sirius.  Since then we have worked with the Greys to develop an
Alien/Human hybrid capable of mind-control. As more and more UFO
sightings occur, it becomes increasingly difficult for
the men in black to control public awareness of the
extraterrestrial presence.
EOF

LEXICON = {
  "extraterrestrial"     => "CANADIAN",
  "life forms"           => "REPRESENTATIVES",
  "Grey aliens"          => "POLITE BACON RANCHERS",
  "the Greys"            => "OUR FRIENDS",
  "Roswell, New Mexico"  => "NIAGARA FALLS",
  "crash-landed"         => "DROPPED BY",
  "lizard people"        => "FOLK SINGERS",
  "Sirius"               => "SASKATCHEWAN",
  "Alien"                => "WILLIAM SHATNER",
  "Human"                => "MILEY CIRUS",
  "mind-control"         => "MAPLE SYRUP MANUFACTURE",
  "men in black"         => "MOUNTIES",
  "UFO"                  => "MOOSE"
}

require "./text"
require "./lexicon"
sanitized = TEXT
LEXICON.each do |term, alternate|
  sanitized = sanitized.gsub(term, alternate)
end
puts sanitized

# shorter way: using a single #gsub. we convert the joined string to a regular expression object. 
terms = LEXICON.keys.join("|")
# => "extraterrestrial|life forms|Grey aliens|the Greys|Roswell, New Mexico|crash-landed|lizard people|Sirius|Alien|Human|mind-control|men in black|UFO"
pattern = Regexp.new(terms)
# => /extraterrestrial|life forms|Grey aliens|the Greys|Roswell, New Mexico|crash-landed|lizard people|Sirius|Alien|Human|mind-control|men in black|UFO/
 
sanitized = TEXT.gsub(pattern) { |match| LEXICON[match] }  # match is the replacement string.
puts sanitized

#another way: Instead of a string or a block, #gsub can accept a hash to use as the replacement. 
sanitized = TEXT.gsub(pattern, LEXICON)
puts sanitized
# In this case, #gsub looks up the matched text in the given hash, and uses the resulting value as the replacement. 