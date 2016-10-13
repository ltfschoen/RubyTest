# load custom Class dependency (from file in same directory)
require_relative 'account'
require_relative 'transaction'

@checking = Account.new(200)
@savings = Account.new(100)
@trans = Transaction.new(@checking, @savings)
@trans.transfer(150)
puts @savings
puts @checking