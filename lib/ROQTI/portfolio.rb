require 'date'

class Portfolio
  def initialize(name, cash=0, account=nil)
    @name = name
    @cash = cash
    @account = account
    @assets = {} #asset objects
    @purchases = []
  end
  
  def get_assets()
    return @assets
  end

  def name
    return @name
  end

  #to change how data is stored in future
  def add_to_purchases(purchase_record)
    @purchases << purchase_record
  end
  
  def add_to_assets(ticker_symbol, asset)
    @assets[ticker_symbol] = asset
  end

  def add_asset(stock, quantity, price)
    new_asset = Asset.new(:quantity => quantity, :price => price, :portfolio_object => self, :security_object => stock)

    add_to_assets(stock.ticker_symbol, new_asset)
  end

  #testing method
  def add_stock(ticker_symbol, num_shares, purchase_price)
    new_stock = Stock.new(ticker_symbol, num_shares)
    add_to_purchases([ticker_symbol, num_shares, purchase_price, DateTime.now()])
    add_to_assets(ticker_symbol, new_stock)
  end
  
  def current_assets()
    for asset in @assets.keys.sort()
      puts @assets[asset]
    end
  end
  
  def purchases_to_date()
    for purchase in @purchases
      puts purchase.to_s
    end
  end

  def value_on_day(year, month, day)
    total_value = 0
    for asset in @assets
     total_value += asset[1].value_on_day(year, month, day)
    end

    return total_value
    
  end

  def purchase_value()  
    total_value = 0
    for asset in @assets
     total_value += asset[1].purchase_value
    end

    return total_value
  end
  
  
  def gain_on_day(year, month, day)
    total_value = 0
    for asset in @assets
     total_value += asset[1].gain_on_day(year, month, day)
    end

    return total_value
    
  end
  
  def stock_dividends()
    total_value = 0
    for asset in @assets
      total_value += asset[1].stock_dividend
    end
    
    return total_value
  
  end

  def pay_dividend(year, month, day, dividend)
    @cash += dividend
  end

  def cash_available()
    return @cash
  end

  def withdraw_cash(withdrawal_amount)
  #attempts to alter @cash, returns false on failure
    if @cash - withdrawal_amount >= 0 
      @cash = @cash - withdrawal_amount
      return true
    else
      return false
    end
  end  

end