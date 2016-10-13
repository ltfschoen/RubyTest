# load custom Class dependency (from file in same directory)
require_relative 'account'
require_relative 'transaction'

@checking = Account.new(200)
@savings = Account.new(100)
json = { balance: '5000' }.to_json
@special = Account.new(1)
@special.from_json(json)
@trans = Transaction.new(@checking, @savings)
@trans.transfer(150)
@trans = Transaction.new(@special, @savings)
@trans.transfer(1000)
puts @savings
puts @checking
puts @special.as_json
puts @special.balance.to_f