require 'caze'

module Lannister
  module UseCases
    class TransferMoney
      include Caze
      define_entry_point :transfer, as: :execute #, use_transaction: true
      define_entry_point :transfer, as: :transfer_money #, use_transaction: true

      extend Forwardable
      def_delegators :Lannister, :get_balance, :transaction_repo

      def initialize(source_account_id:, destination_account_id:, amount:)
        @source_account_id = source_account_id
        @destination_account_id = destination_account_id
        @amount = amount
      end

      def transfer
        if get_balance(account_id: source_account_id) >= amount
          transaction_repo.persist(debit_transaction)
          transaction_repo.persist(credit_transaction)
        else
          false
        end
      end

      private

      def debit_transaction
        Entities::Transaction.new(account_id: source_account_id, amount: - amount)
      end

      def credit_transaction
        Entities::Transaction.new(account_id: destination_account_id, amount: amount)
      end

      attr_reader :source_account_id, :destination_account_id, :amount
    end
  end
end
