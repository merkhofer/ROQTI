class Security
  attr_reader :num_shares_in_brokerage
  def initialize(ticker_symbol, num_shares = 0)
    @ticker_symbol = ticker_symbol
    @data_handler = DataHandler.new(self)
    @num_shares_in_brokerage = num_shares
    @assets = {}
  end
  
  def add_shares_to_brokerage(num_shares)
    @num_shares_in_brokerage += num_shares
  end

  def attach_to_asset(asset)
    @assets[asset.portfolio_object.name] = asset

  end

  def show_security_owners()
    for asset in @assets.keys
      puts "#{@assets[asset].portfolio_object.name} -> #{@assets[asset].quantity}"
    end
  end
  
  def day_closing_price(year, month, day)
    return @data_handler.retrieve(year, month, day).to_f
  end

  def current_price()
    #TODO: return @data_handler.most_recent_price()
    return 10
  end

  def to_s
    #TODO: this is a stub I used for Purchase.to_s
    return "SECURITY: #{@ticker_symbol}"
  end

  def buy
    #TODO: is this where things are bought? TESTING STUB
    return true
  end
end