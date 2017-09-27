# a file called .netrc, which stores usernames and passwords for remote hosts.
machine rubytapas.com login avdi password xyzzy
machine example.org login marvin password plugh

# write our own parser for this simplified .netrc format:
open('.netrc').lines do |line|
  columns  = line.split
  machine  = columns[1]
  login    = columns[3]
  password = columns[5]
  puts "#{machine}: #{login} / #{password}"
end
# >> rubytapas.com: avdi / xyzzy
# >> example.org: marvin / plugh

# we can implicitly splat arrays into multiple variables on assignment.
open('.netrc').lines do |line|
  machinekey, machine, loginkey, login, passwordkey, password  = line.split
  puts "#{machine}: #{login} / #{password}"
end
# >> rubytapas.com: avdi / xyzzy
# >> example.org: marvin / plugh

# But now we have a bunch of useless variables ending in -key which exist simply to be placeholders. 
# We need to clarify that we don't care about any of those fields by using the variable name ignored for all of them:
open('.netrc').lines do |line|
  ignored, machine, ignored, login, ignored, password  = line.split
  puts "#{machine}: #{login} / #{password}"
end

# As a separate method:
# If we replace our ignored variable with a variable called _, Ruby relaxes its usual rules about duplicate argument names. 
def netrc_entries
  open('.netrc').lines do |line|
    yield(*line.split)
  end
end
 
netrc_entries do |_, machine, _, login, _, password|
  puts "#{machine}: #{login} / #{password}"
end                                                           
# >> rubytapas.com: avdi / xyzzy
# >> example.org: marvin / plugh