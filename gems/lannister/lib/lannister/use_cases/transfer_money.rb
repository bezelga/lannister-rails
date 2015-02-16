# Transfer Money - use case
#
# Data:
# <source_account_id>, <destination_account_id>, <amount>
#
# Primary course:
#
#  1. Client triggers “Transfer Money” with above data.
#  2. System validates all data.
#  3. System creates a debit on the source account.
#  4. System creates a credit on the destination account.
#
# Exception Course: Not enough money on the source account.
#
#  1. System cancels the transfer.
#

require 'caze'
require 'forwardable'

module Lannister
  module UseCases
    class TransferMoney
      include Caze

      export :transfer, as: :transfer_money

      extend Forwardable
      def_delegators :Lannister, :get_balance, :trade_repo

      def initialize(source_account_id:, destination_account_id:, amount:)
        @source_account_id = source_account_id
        @destination_account_id = destination_account_id
        @amount = amount
      end

      def transfer
        return false if source_account_balance < amount

        debit_source_account
        credit_destination_account
      end

      private

      def source_account_balance
        get_balance(account_id: source_account_id)
      end

      def debit_source_account
        trade_repo.persist Entities::Trade.new(account_id: source_account_id, amount: - amount)
      end

      def credit_destination_account
        trade_repo.persist Entities::Trade.new(account_id: destination_account_id, amount: amount)
      end

      attr_reader :source_account_id, :destination_account_id, :amount
    end
  end
end
