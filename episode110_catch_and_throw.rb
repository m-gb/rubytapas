# exceptions for flow control? That's where code raises an exception, not to signal an error,
# but in order to make an early escape from a deeply nested chain of method calls.
class ExcerptParser < Nokogiri::XML::SAX::Document
    
      class DoneException < StandardError; end
    
      # ...
    
      def self.get_excerpt(html, length, options)
        me = self.new(length,options)
        parser = Nokogiri::HTML::SAX::Parser.new(me)
        begin
          parser.parse(html) unless html.nil?
        rescue DoneException                           #
          # we are done
        end
        me.excerpt
      end
    
      # ...
    
      def characters(string, truncate = true, count_it = true, encode = true)
        return if @in_quote
        encode = encode ? lambda{|s| ERB::Util.html_escape(s)} : lambda {|s| s}
        if count_it && @current_length + string.length > @length
          length = [0, @length - @current_length - 1].max
          @excerpt << encode.call(string[0..length]) if truncate
          @excerpt << "…"
          @excerpt << "</a>" if @in_a
          raise DoneException.new
        end
        @excerpt << encode.call(string)
        @current_length += string.length if count_it
      end
end

# in order to get a page excerpt, the ExcerptParser only needs to collect text from the HTML page until it reaches the desired excerpt length.
# this class needs to be able to “break out” of the parser and signal the code that started the parse that it has all it needs (by raising an exception).

class ExcerptParser < Nokogiri::XML::SAX::Document
 
  # ...
 
  def self.get_excerpt(html, length, options)
    me = self.new(length,options)
    parser = Nokogiri::HTML::SAX::Parser.new(me)
    catch(:done) do   #If at any point code executed within this block “throws” the symbol :done, catch will do exactly what it sounds like – catch the symbol.
      parser.parse(html) unless html.nil? #Execution will then proceed onward from the end of the catch block.
    end
    me.excerpt
  end
 
  # ...
 
  def characters(string, truncate = true, count_it = true, encode = true)
    return if @in_quote
    encode = encode ? lambda{|s| ERB::Util.html_escape(s)} : lambda {|s| s}
    if count_it && @current_length + string.length > @length
      length = [0, @length - @current_length - 1].max
      @excerpt << encode.call(string[0..length]) if truncate
      @excerpt << "…"
      @excerpt << "</a>" if @in_a
      throw :done  #We change the raise to a throw. When the ExcerptParser finds it has enough text for an excerpt, it “throws” the :done symbol.
    end
    @excerpt << encode.call(string)
    @current_length += string.length if count_it
  end
end

# the code no longer suggests an error condition where there actually is none.
# By contrast, with a begin/rescue/end block we have to skip down to the end of code in question to see what errors might occur.
# This is fine for errors, but less fine for perfectly normal early returns.