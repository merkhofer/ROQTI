require_relative '../lib/ROQTI'

describe Purchase, "#check_cash" do
  it "should check if there's enough money to do this transaction" do
    security = Security.new("aapl", 1000)
    portfolio = Portfolio.new("Liz", 10000000)
    purchase = Purchase.new({:purchase_amount => 1, :security_to_buy => security, :source_portfolio => portfolio})
    purchase.check_cash.should eq(true)
  end
end

describe Purchase, "#to_s" do
  it "should print a nice string" do
    security = Security.new("aapl", 1000)
    portfolio = Portfolio.new("Liz", 10000000)
    purchase = Purchase.new({:purchase_amount => 1, :security_to_buy => security, :source_portfolio => portfolio})
    #Security needs to_s method
    purchase.to_s.should == "Liz purchase [ORDER]: 1 of SECURITY: aapl for 10."
  end
end

describe Purchase, "#complete_purchase" do
  it "should succesfully make a purchase" do
    security = Security.new("aapl", 1000)
    portfolio = Portfolio.new("Liz", 10000000)
    purchase = Purchase.new({:purchase_amount => 1, :security_to_buy => security, :source_portfolio => portfolio})
    #THIS IS FAILING
    purchase.complete_purchase.should eq(true)
  end
end
