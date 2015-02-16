require 'lannister/version'

require 'lannister/entities/trade'
require 'lannister/repositories/trade_repo'

#require 'lannister/use_cases'
require 'lannister/use_cases/get_balance'
require 'lannister/use_cases/transfer_money'
require 'caze'

require 'accounting/engine'


module Lannister
  include Caze

  has_use_case :get_balance, UseCases::GetBalance
  has_use_case :transfer_money, UseCases::GetBalance, transactional: true

  class << self
    attr_writer :trade_repo

    def configure
      yield self
    end

    def trade_repo
      #@trade_repo ||= Repositories::TradeRepo.new
      @trade_repo ||= Accounting::TradeRepo
    end
  end
end
