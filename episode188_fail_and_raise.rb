# At this point, most of the Ruby world has embraced #raise over #fail.
# use raise when re-raising an exception.
# That way, the choice of raise instead of fail provides an extra cue to the reader that something out of the ordinary is going on.
['--require', '-r MODULE',
  "Require MODULE before executing rakefile.",
  lambda { |value|
    begin
      require value
    rescue LoadError => ex
      begin
        rake_require value
      rescue LoadError
        raise ex
      end
    end
  }
],
# In the specific case where doing an ordinary require raises a LoadError,
# this code rescues the error and then tries again to require the file using the special rake_require method. 
# If that too raises a LoadError, there are no options left. And so it re-raises the exception.

# begin/raise/rescue is used for errors, and nothing else. 