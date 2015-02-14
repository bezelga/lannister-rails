module Lannister
  module UseCases
    class GetBalance
      def self.execute(account_id:)
        Lannister.transaction_repo.balance(account_id: account_id)
      end
    end
  end
end
