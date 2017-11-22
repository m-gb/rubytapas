require 'delegate'
class AuditedAccount < SimpleDelegator # SimpleDelegator enables us to augment the methods we care about, and ignore all the others.
  def initialize(account, audit_log)
    super(account) #
    @audit_log = audit_log
  end

  def deposit(amount)
    super
    @audit_log.record(number, :deposit, amount, balance_cents)
  end

  def withdraw(amount)
    super
    @audit_log.record(number, :withdraw, amount, balance_cents)
  end
end
# Thnaks to the delegate library, if we compare the raw account and the decorated account, the result is true.
# This helps ensure that delegator objects are usable as drop-in replacements for the raw object in as many contexts as possible.

require "./bank_account"
require "./audit_log"
require "./audited_account"

account = BankAccount.new(123456)
log = AuditLog.new

aa = AuditedAccount.new(account, log)

account.number                  # => 123456
aa.number                       # => 123456

aa == account                   # => true

# Defining a variant of AuditedAccount using DelegateClass(invoking a global method):

require "./bank_account"
require "delegate"

DelegateClass(BankAccount) # Providing the name of the class we intend to decorate(generates a new base class at runtime).
# => #<Class:0x007f9daf5f9c50>

require "delegate"
require "./bank_account"

class AuditedAccount2 < DelegateClass(BankAccount) # Instances of this class will respond to the number attribute(because it generates proxy methods ahead of time).
  def initialize(account, audit_log)
    super(account)
    @audit_log = audit_log
  end

  def deposit(amount)
    super
    @audit_log.record(number, :deposit, amount, balance_cents)
  end

  def withdraw(amount)
    super
    @audit_log.record(number, :withdraw, amount, balance_cents)
  end
end

require "./bank_account"
require "./audit_log"
require "./audited_account"
require "./audited_account2"

account = BankAccount.new(123456)
log = AuditLog.new

aa1 = AuditedAccount.new(account, log)
aa2 = AuditedAccount2.new(account, log)

aa1.number                      # => 123456
aa2.number                      # => 123456

AuditedAccount.instance_methods.include?(:number)
# => false

AuditedAccount2.instance_methods.include?(:number)
# => true

require "./bank_account.rb"

class InterestAccount < BankAccount
  def interest_rate
    1.3
  end
end

require "./interest_account"
require "./audit_log"
require "./audited_account2"

account = InterestAccount.new(123456)
aa = AuditedAccount2.new(account, AuditLog.new) # DelegateClass-generated classes just fall back to dynamic method discovery when forwarding to a method they don't know about.

account.interest_rate           # => 1.3
aa.interest_rate                # => 1.3

# If we know exactly the class we plan on wrapping, we might as well use DelegateClass (better performance and introspection).
# To minimize dependencies or to decorate a range of similar classes, SimpleDelegator is an easy choice.