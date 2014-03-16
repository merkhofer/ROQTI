require_relative "stock.rb"
require_relative "data_handler.rb"
require_relative "File_Handler.rb"
require_relative "portfolio.rb"
require_relative "account.rb"
require_relative "brokerage.rb"

# 1 - create a portfolio
ted = Portfolio.new("Ted")
ted_2 = Portfolio.new("Ted 2")

# 1b - add some stocks
apple = Stock.new("aapl")
apple.refresh_data("./Test_Data/aapl.csv")
msft = Stock.new("msft")
msft.refresh_data("./Test_Data/msft.csv")
amzn = Stock.new("amzn")
amzn.refresh_data("./Test_Data/amzn.csv")
goog = Stock.new("goog")
goog.refresh_data("./Test_Data/goog.csv")
yhoo = Stock.new("yhoo")
yhoo.refresh_data("./Test_Data/yhoo.csv")



ted.add_asset(apple, 5, 500)
ted.add_asset(msft, 50, 26)

ted_2.add_asset(apple, 50, 500)


# 2 - create an account and add the portfolio created above
teds_account = Account.new({:name => "Ted's Account", :portfolios => [ted, ted_2]})


andrews_account = Account.new({:name => "Andrew's Account"})
andrew_1 = Portfolio.new("Andrew 1")
andrew_1.add_asset(goog, 10, 98)
andrews_account.add_portfolio(andrew_1)



puts teds_account.purchase_value()

ted_3 = Portfolio.new("Ted 3")
ted_3.add_asset(msft, 10, 46)
teds_account.add_portfolio(ted_3)

puts teds_account.purchase_value()


# 3 - create a brokerage

james_brokerage = Brokerage.new(:name => "james' house o' dough")
james_brokerage.add_account(teds_account)
james_brokerage.add_account(andrews_account)
puts james_brokerage.purchase_value()

puts "*" * 50
james_brokerage.print_ranked_accounts_by_purchase_value()
puts "*" * 50

puts "Cash available in Andrew's account: #{andrew_1.cash_available()}"
goog.pay_dividend(2004,12,12,10)
puts "google just paid a dividend"
puts "Cash available in Andrew's account: #{andrew_1.cash_available()}"
