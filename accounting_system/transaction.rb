class Transaction

  # Delegate to Setter methods instead of set instance variables directly.  
  def initialize(account_a, account_b)
    self.account_a = account_a
    self.account_b = account_b
  end

  # Setter method enforces rules 
  def account_a=(account_a)
    @account_a = account_a
  end

  def account_b=(account_b)
    @account_b = account_b
  end

  public

    def transfer(amount)
      validate_sufficient_funds(@account_a, amount)
      debit(@account_a, amount)
      credit(@account_b, amount)
    end

  private
  
    def debit(account, amount)
      account.balance -= amount
    end

    def credit(account, amount)
      account.balance += amount
    end

    def validate_sufficient_funds(account_a, amount)
      raise CustomError.new('error'), 'Transfer amount cannot exceed account balance.' if not is_sufficient_funds?(account_a, amount)
    end

    def is_sufficient_funds?(account_a, amount)
      account_a.balance >= amount
    end

end