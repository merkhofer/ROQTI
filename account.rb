class Account
  def initialize(args)
    # assume that an account can have multiple portfolios associated with it.
    # also, assume that you are normall attached to only one brokerage
    @name = args[:name] # notice, we're using a hash to pass parameters here... what might that mean when invoking Account.new(**)?
    @brokerage = nil

    #Optionally initialize with existing portfolios

    if args.key?(:portfolios)
      @portfolios = args[:portfolios]
    else
      @portfolios = []
    end

    @purchases = []
  end

  def total_returns()
    returns = 0
    for portfolio in @portfolios
      returns += portfolio.total_returns # notice that portfolios will have to generate their own total returns
    end
    return returns
  end

  def purchase_value()
    purchase_value = 0
    for portfolio in @portfolios
      purchase_value += portfolio.purchase_value
    end
    return purchase_value
  end

  def add_portfolio(portfolio)
    @portfolios << portfolio
  end

  def account_value()
    value = 0
    for portfolio in @portfolios
      value += portfolio.current_value
    end
    return value    
  end

  def to_s
    return "#{@name}: #{self.purchase_value()}"
  end
end
