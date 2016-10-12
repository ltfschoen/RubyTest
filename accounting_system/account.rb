class Account

  # Read-only access
  attr_accessor :balance

  def initialize(balance)
    @balance = balance
  end

  # Call with `puts <class_instance_name>`
  def to_s
    "Account Balance: #{@balance}"
  end

end