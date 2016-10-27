require_relative '../../accounting_system/account.rb'
require_relative '../../helpers/custom_error.rb'

RSpec.describe Account, "#balance" do

	before(:each) do
		@checking = Account.new(200)
		@savings = Account.new(100)
    @same_balance_as_checking = Account.new(200)
    @special = Account.new(1000)
	end

	context "with accounts" do

		it "creates accounts with valid balances >= 0" do
			expect(@savings.balance).to eq 100
			expect(@checking.balance).to eq 200
		end

		it "rescues custom error when try to create account with balance < 0" do
			expect{ Account.new(-1) }.to_not raise_error(CustomError)
    end

    it "compares account balances correctly" do
      expect(@checking == @same_balance_as_checking).to equal true
			expect(@checking > @savings).to equal true
    end

		it "creates unique object ids for accounts with equal balance" do
			expect(@checking.object_id == @same_balance_as_checking.object_id).to equal false
    end

    # # Use for debugging purposes only to delete Account Class Instances
    # it "destroys Account class instance objects" do
		# 	GC.enable
		# 	GC.stress = true
		# 	GC::Profiler.enable
     #  expect(Account.count).to_not equal 0
		# 	p "Account Class Instances created by previous tests: #{Account.count}"
		# 	Account.all.each { |account| Account.destruct(account) }
    #   # http://stackoverflow.com/questions/9406419/deleting-an-object-in-ruby
    #   # ObjectSpace.garbage_collect
		# 	p "Account Class Instances after being destructed: #{Account.count}"
		# 	# Account.all.each { |acct| p acct.balance.to_f.to_s + acct.object_id.to_s }
		# 	puts GC::Profiler.result
		# 	expect(Account.count).to equal 0
		# end

		it "sorts account balances in descending order" do
      # All Account Class Instances created by each prior test
			@accounts_desc_order = Account.all.sort.reverse # descending order
			# @accounts_desc_order.each { |account| p account.balance.to_f.to_s + ", " + account.object_id.to_s }

      # Must be greater than or equal since all instance balances may be equal or duplicates
			expect(@accounts_desc_order[0] >= @accounts_desc_order[1]).to equal true
		end
	end
end