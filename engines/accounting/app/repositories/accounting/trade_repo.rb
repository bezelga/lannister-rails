require_relative '../../models/accounting/trade'

module Accounting
  class TradeRepo
    class << self
      def persist(entity)
        row = Trade.create!(account_id: entity.account_id,
                                  amount: entity.amount)
        entity.id = row.id
        entity
      end

      def count
        Trade.count
      end

      def balance(account_id:)
        Trade.where(account_id: account_id).sum(:amount)
      end

      def delete_all
        Trade.delete_all
      end
    end
  end
end
