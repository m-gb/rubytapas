# One way to be kind to users of your code is to include “executable documentation” of these abstract methods using stubs that raise NotImplementedError. 
# LogicalCondition is an abstract class: that is, a class that must be subclassed in order to be used. 
class SpaceAvailableCondition < LogicalCondition
  private
  def condition_holds?
    !client.full?
  end
end
 
class ItemAvailableCondition < LogicalCondition
  private
  def condition_holds?
    !client.empty?
  end
end
# NotImplementedError inherits from ScriptError, which in turn inherits directly from Exception.
begin
    raise NotImplementedError
  rescue
    puts "Rescued error"
  end

def condition_holds?
  raise NotImplementedError, 
        "You must implement a #condition_holds? predicate that "
        "tests whether the condition is currently true"
end
# Now if we try to use a LogicalCondition without subclassing and overriding #predicate_holds?, we get a helpful message telling us what we did wrong.
# users of the class can also read through the class source code and easily see the methods which are required but not provided.