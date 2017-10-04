require 'logger'

class Picard
  def make_it_so(log=Logger.new($stdout))
    log.info "I have instructed engineering to fix my tea kettle"
    Geordi.new(log).fix_it
  end
end

class Geordi
  def initialize(log)
    @log = log
  end

  def fix_it
    @log.info "Reversing the flux phase capacitance!"
    @log.info "Bounding a tachyon particle beam off of Data's cat!"
    Barclay.new(@log).monitor_sensors
  end
end

class Barclay
  def initialize(log)
    @log = log
  end

  def monitor_sensors
    @log.warn "Warning, bogon levels are rising!"
  end
end

Picard.new.make_it_so
# >> I, [2013-06-04T16:10:03.056063 #11351]  INFO -- : I have instructed engineering to fix my tea kettle
# >> I, [2013-06-04T16:10:03.056286 #11351]  INFO -- : Reversing the flux phase capacitance!
# >> I, [2013-06-04T16:10:03.056336 #11351]  INFO -- : Bounding a tachyon particle beam off of Data's cat!
# >> W, [2013-06-04T16:10:03.056393 #11351]  WARN -- : Warning, bogon levels are rising!

class Picard
  def make_it_so(log=Logger.new($stdout))
    log.info "I have instructed engineering to fix my tea kettle"
    Geordi.new(log, quiet: true).fix_it
  end
end
 
class Geordi
  def initialize(log, quiet: true)
    @log = log
  end

# This device mimics the protocols of our usual ship's log subsystem, but simply discards its input unused. 
class NullLogger
    def debug(*); end
    def info(*); end
    def warn(*); end
    def error(*); end
    def fatal(*); end
  end
  
  log = NullLogger.new
  
  puts "before"
  Picard.new.make_it_so(log)
  puts "after"
  # >> before
  # >> after
  
