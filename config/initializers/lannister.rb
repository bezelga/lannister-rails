Lannister.configure do |config|
  config.trade_repo = Accounting::TradeRepo
  config.transaction_handler = ActiveRecord::Base
end
