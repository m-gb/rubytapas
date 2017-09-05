require 'logger'

class NullLogger
  def method_missing(*); end
end

options = {logger: false}
logger = options.fetch(:logger){Logger.new($stdout)}
unless logger
  logger = NullLogger.new
end
logger
# => #<NullLogger:0x00000003b73858>

{}[:foo] || :default             # => :default
{foo: nil}[:foo] || :default     # => :default
{foo: false}[:foo] || :default   # => :default

{}.fetch(:foo){:default}             # => :default
{foo: nil}.fetch(:foo){:default}     # => nil
{foo: false}.fetch(:foo){:default}   # => false
