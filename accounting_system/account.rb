require 'active_model'
require 'bigdecimal'
require_relative '../helpers/numeric_overrides'

class Account
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