require 'lannister/version'

require 'lannister/entities/transaction'
require 'lannister/repositories/transaction_repo'

#require 'lannister/use_cases'
require 'lannister/use_cases/get_balance'
require 'lannister/use_cases/transfer_money'

# WITH the engine dependency
#require 'rails/railties'
#require 'active_record'
#require 'accounting'
#require 'accounting/engine'
#require "#{Accounting::Engine.root}/app/models/accounting/transaction"
#require "#{Accounting::Engine.root}/app/repositories/accounting/transaction_repo"

require 'caze'

module Lannister
  include Caze
  define_use_cases transfer_money: UseCases::TransferMoney,
                   get_balance:    UseCases::GetBalance

  extend Forwardable

  class << self
    attr_writer :transaction_repo

    def transaction_repo
      @transaction_repo ||= Repositories::TransactionRepo.new
      #@transaction_repo ||= Accounting::TransactionRepo
    end
  end
end
