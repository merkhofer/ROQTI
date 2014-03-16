require_relative "stock.rb"
require_relative "data_handler.rb"
require_relative "File_Handler.rb"
require_relative "portfolio.rb"
require_relative "account.rb"

ted = Portfolio.new("Ted")
james = Portfolio.new("James")


apple = Stock.new("aapl")
apple.refresh_data("./Test_Data/aapl.csv")
msft = Stock.new("msft")
msft.refresh_data("./Test_Data/msft.csv")

apple.day_closing_price("2012", "01", "19")
msft.day_closing_price("2012", "01", "19")


puts apple.num_shares_in_brokerage()
ted.add_asset(apple, 5, 500)
ted.add_asset(msft, 50, 26)
puts apple.num_shares_in_brokerage()

james.add_asset(apple, 25, 200)
james.add_asset(msft, 200, 75)

puts apple.num_shares_in_brokerage()

puts "Ted: #{ted.object_id}"
ted.current_assets()
puts "*" * 50
puts "James: #{james.object_id}"
james.current_assets()

puts "*" * 50
puts "Hal, who owns Apple stocks here?"
apple.show_security_owners()

puts "*" * 50
puts "Looking at more information about a portfolio"


  ted.current_assets()
puts  "Ted's #{ted.purchase_value()}"
puts "%" * 50
puts ted.value_on_day("2012", "01", "19")
puts ted.gain_on_day("2012", "01", "19")


  #ted.add_stock("aapl", 100, 4750)
  #ted.add_stock("pg", 50, 9600)
  #ted.add_stock("bng", 100, 3800)

  #ted.current_assets()
  #ted.purchases_to_date()

  #teds_account = Account.new({:name => "Ted's Account", :portfolios => [ted,]})
  #puts teds_account.account_value()
  #puts teds_account.total_returns()


#apple = Stock.new("aapl")

#apple.refresh_data("./Test_Data/aapl.csv")
#apple.day_closing_price("2007", "01", "19")
#apple.day_closing_price("2012", "01", "19")
