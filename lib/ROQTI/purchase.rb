class Purchase
  #attrreader :purchase_price
  def initialize(args)
    # so this is a more complicated class. We'll need some mechanism to have it know what kind of asset is being purchased.
    # For example, it should be able to args that include the asset purchased, the quantity, and the price (assume that this is a finalized purchase and not an order)
    @status = "ORDER"
    @purchase_amount = args[:purchase_amount]
    @purchase_asset = nil #will be filled when bought
    @security = args[:security_to_buy]
    @source_portfolio = args[:source_portfolio]

    # one key thing here will be figuring out how to send a message to the portfolio, account, and brokerage to record a link to the purchase
    calc_price() #get price from the security 
  end

  def not_complete
    #some things should only be possible when order is not complete yet
    if @status == "ORDER" or @status == "FAILED"
      return true
    else
      return false
    end
  end

  def calc_price
    if not_complete
      purchase_price = @purchase_amount * @security.current_price #stubbed in security to return 0
      @purchase_price = purchase_price
    end #and if the order is complete, purchase price is set
  end

  def check_cash
    money_left = @source_portfolio.cash_available - @purchase_price 
    puts "#{@source_portfolio.name} will have #{money_left} remaining after this purchase"
    return money_left >= 0 #so true if able to make purchase
  end
    
  def check_price_change
    #TODO: return @security.current_price = @purchase_price
    return false
  end

  def shares_in_brokerage
    #return @security.num_shares_in_brokerage
  end

  def complete_purchase
    calc_price() #update the price at the last second
    if not self.not_complete #ie, don't let this purchase instance happen more than once
      puts "This purchase is already complete"
      return false
    end
    if not check_cash
      puts "Not enough money"
      @status = "FAILED"
      return false
    end
    if not shares_in_brokerage
      puts "Not enough shares of #{@purchase_asset} in brokerage"
      @status = "FAILED"
      return false
    end
    #if none of those stopped you ... I guess you can have your asset
    if @source_portfolio.withdraw_cash(@purchase_amount) #if you succesfully get the cash
      if @security.buy(self) #this is not implemented, updates values, returns t on success/f on failure
        @status = "SUCCESS"
        return true
      else
        puts "Unexpected problem at brokerage"
        @status = "FAILED"
        return false
      end
    else
      puts "Unexpected problem withdrawing cash"
      @status = "FAILED"
      return false
    end
  end
    
  def to_s
    return "#{@source_portfolio.name} purchase [#{@status}]: #{@purchase_amount} of #{@security} for #{@purchase_price}." #how's the to_s on security objects?
  end
end