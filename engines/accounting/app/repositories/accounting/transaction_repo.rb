module Accounting
  require_relative '../../models/accounting/transaction'
  class TransactionRepo
    class << self
      def persist(entity)
        row = Transaction.create!(account_id: entity.account_id,
                                  amount: entity.amount)
        entity.id = row.id
        entity
      end

      def count
        Transaction.count
      end

      def balance(account_id:)
        Transaction.where(account_id: account_id).sum(:amount)
      end

      def delete_all
        Transaction.delete_all
      end
    end
  end
end
