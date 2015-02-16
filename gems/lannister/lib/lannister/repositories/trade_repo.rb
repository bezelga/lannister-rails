require 'active_support/core_ext/enumerable'

module Lannister
  module Repositories
    class TradeRepo
      def initialize
        @rows = {}
        @id = 0
      end

      def persist(entity)
        @id += 1
        entity.id = @id
        rows[@id] = entity
        entity
      end

      def count
        rows.length
      end

      def balance(account_id:)
        rows_by_account(account_id).sum { |_, r| r.amount }
      end

      def delete_all
        @rows = {}
        @id = 0
      end

      private

      attr_reader :rows

      def rows_by_account(account_id)
        rows.select{ |_, row| row.account_id == account_id }
      end
    end
  end
end
