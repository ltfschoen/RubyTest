require_relative '../../accounting_system/account.rb'
require_relative '../../accounting_system/transaction.rb'
require_relative '../../helpers/custom_error.rb'

RSpec.describe Transaction, "#debit" do

	before(:each) do
		@checking = Account.new(200)
		@savings = Account.new(100)
		@trans = Transaction.new(@checking, @savings)
	end

	context "with only savings and checking accounts" do

		it "has default balances initially setup for each account for zero transaction" do
			@trans.transfer(0)
			expect(@savings.balance).to eq 100
			expect(@checking.balance).to eq 200
		end

		it "raises error when attempt to transfer value that exceeds 'from account' balance" do
			expect(@savings.valid?).to eq true
			expect{ @trans.transfer(201) }.to raise_error(CustomError)
		end
	end

end