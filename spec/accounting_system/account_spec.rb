require_relative '../../accounting_system/account.rb'
require_relative '../../helpers/custom_error.rb'

RSpec.describe Account, "#balance" do

	before(:each) do
		@checking = Account.new(200)
		@savings = Account.new(100)
	end

	context "with only two accounts" do

		it "creates accounts with valid balances >= 0" do
			expect(@savings.balance).to eq 100
			expect(@checking.balance).to eq 200
		end

		it "raises argument error when try to create account with balance < 0" do
			expect{ Account.new(-1) }.to raise_error(CustomError)
		end
	end
end