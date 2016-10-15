require 'active_model'
require 'bigdecimal'
require_relative '../helpers/numeric_overrides'

class Account
	include Comparable
	include ActiveModel::Serializers::JSON
  include ActiveModel::Validations
  validates :balance, :numericality => { :greater_than_or_equal_to => 0 }

  # Define default Getter methods, but not Setter methods
  attr_reader :balance

  # Delegate to Setter methods instead of set instance variables directly.  
  def initialize(balance)
  	self.balance = balance
  end

  # Setter method enforces rules  
  def balance=(balance)
  	begin
	  	unless is_balance_zero?(balance)  
		  	validate_balance_numeric(balance)
		  	validate_balance_non_negative(balance)
		  end
	    @balance = BigDecimal.new(convert_balance_to_string(balance))
	  rescue CustomError
	  ensure
	  	@balance = 0 if @balance.nil?
	  end
  end

  # Call with `puts <class_instance_name>`
  def to_s
    "Account Balance: #{@balance}"
  end

	# Add all Comparator operators to compare Account Class Instances variable balance
	def <=>(other_account)
		self.balance <=> other_account.balance
	end

	# Quantity of Class Instance Objects
	def self.all; ObjectSpace.each_object(self).to_a end
	def self.count; all.length end

	# Remove a specific Class Instance Object
	def self.remove(account_object, &block)
		ObjectSpace.define_finalizer(account_object, Account.method(:delete))
		block
	end

	def self.destruct(account_object)
		block_remove = Account.remove(account_object) { |param| Account.delete(param) }
		p "Deleting #{account_object}"
		block_remove.call(account_object)
	end

	def self.delete(account_object)
		p "Count before delete #{self.count}"
		GC.start(full_mark: true, immediate_sweep: true)
		p "Count after delete #{self.count}"
	end

	private

	  # Implementation of ActiveModel::Serializers::JSON http://guides.rubyonrails.org/active_model_basics.html
	  def attributes=(hash)
	    hash.each do |key, value|
	      send("#{key}=", value)
	    end
	  end
	 
	  def attributes
	    { 'balance' => nil }
	  end

		def convert_balance_to_string(balance)
			(balance.kind_of? Numeric) || (balance.kind_of? String) ? balance.to_s : (raise CustomError.new('Balance must contain numeric characters.'))
		end

		def convert_balance_to_bigdecimal(balance)
			(balance.kind_of? Numeric) || (balance.kind_of? String) ? BigDecimal.new(convert_balance_to_string(balance)) : (raise CustomError.new('Balance must contain numeric characters.'))
		end

		def validate_balance_numeric(balance)
			raise CustomError.new('Balance string must contain valid numeric characters.') if not is_balance_numeric?(balance)
		end

		def validate_balance_non_negative(balance)
			raise CustomError.new('Balance must not be negative.') if is_balance_numeric?(balance) && is_balance_negative?(balance)
		end

		def is_balance_zero?(balance)
			!convert_balance_to_bigdecimal(balance).to_f.nonzero?
		end

		def is_balance_numeric?(balance)
			!BigDecimal.new(convert_balance_to_string(balance)).nonzero?.nil?
		end

		def is_balance_negative?(balance)
			BigDecimal.new(convert_balance_to_string(balance)).negative?
		end
end