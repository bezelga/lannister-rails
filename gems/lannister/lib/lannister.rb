require 'lannister/version'

require 'lannister/entities/transaction'
require 'lannister/repositories/transaction_repo'

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
  # this will call the class method transfer_money inside the
  # DOUBT: what if it was execute?
  define_use_cases transfer_money: UseCases::TransferMoney

  extend Forwardable

  class << self
    #def transfer_money(source_account_id:, destination_account_id:, amount:)
      #UseCases::TransferMoney.execute(source_account_id: source_account_id,
                                      #destination_account_id: destination_account_id,
                                      #amount: amount)
    #end

    def get_balance(account_id:)
      UseCases::GetBalance.execute(account_id: account_id)
    end

    def transaction_repo
      @transaction_repo ||= Repositories::TransactionRepo.new
      #@transaction_repo ||= Accounting::TransactionRepo
    end
  end
end
