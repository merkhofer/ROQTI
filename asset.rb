class Asset
  attr_reader :quantity, :price, :security_object
  def initialize(args)
    @security_object = args[:security_object] # attach asset to a security object
    @portfolio_object = args[:portfolio_object] # attach asset to a portfolio object
    @quantity = args[:quantity]
    @price = args[:price]
    #@dividend_price = #how do i get dividend price here? put something in the attr_reader?
    

    @security_object.add_shares_to_brokerage(@quantity)
    @security_object.attach_to_asset(self)
    #@ticker_symbol = ticker_symbol
    #@data_handler = DataHandler.new(self)
    #@num_shares = num_shares
  end

  def portfolio_object
    return @portfolio_object
  end

  def to_s()
    return "#{@security_object.ticker_symbol}:\t#{@quantity}"
  end
  
  
  def value_on_day(year, month, day)
    total_value = @quantity * @security_object.day_closing_price(year, month, day)
    return total_value

  end
  
  def purchase_value()  
    total_value = @quantity * @price
    return total_value
  end
  
  def gain_on_day(year, month, day)
    gainz = self.value_on_day(year, month, day) - self.purchase_value
    return gainz
  end
  
  def pay_dividend(year, month, day, dividend)
    total_dividend = @quantity * dividend
    @portfolio_object.pay_dividend(year, month, day, total_dividend)
  end
    
  
  

end