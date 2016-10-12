# load custom Class dependency (from file in same directory)
require_relative 'account'
require_relative 'transaction'

savings = Account.new(100)
checking = Account.new(200)
trans = Transaction.new(checking, savings)
trans.transfer(50)
puts savings
puts checking