module Lannister
  module Entities
    class Transaction
      attr_accessor :id, :account_id, :amount

      def initialize(attributes = {})
        @id, @account_id, @amount = attributes.values_at(:id, :account_id, :amount)
      end
    end
  end
end
