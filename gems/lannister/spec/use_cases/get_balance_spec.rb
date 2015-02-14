require 'spec_helper'

module Lannister
  module UseCases
    describe GetBalance do
      describe '.execute' do
        subject(:execute) { described_class.execute(account_id: account_id) }

        let(:account_id) { 1 }
        let(:amount) { 10_000 }
        let(:transaction) { Entities::Transaction.new(account_id: account_id, amount: amount) }

        context 'when there is only one credit transaction' do
          before { Lannister.transaction_repo.persist(transaction) }

          it { expect(execute).to eq(amount) }
        end

        context 'when there are two credit transactions' do
          let(:another_amount) { 2_200 }
          let(:another_transaction) { Entities::Transaction.new(account_id: account_id, amount: another_amount) }
          before { [transaction, another_transaction].each { |t| Lannister.transaction_repo.persist(t) } }

          it { expect(execute).to eq(amount + another_amount) }
        end

        context 'when there is a credit and a debit' do
          let(:debit_amount) { -500 }
          let(:debit_transaction) { Entities::Transaction.new(account_id: account_id, amount: debit_amount) }
          before { [transaction, debit_transaction].each { |t| Lannister.transaction_repo.persist(t) } }

          it { expect(execute).to eq(amount + debit_amount) }
        end

        context 'transactions from another accounts' do
          let(:debit_amount) { -500 }
          let(:debit_transaction) { Entities::Transaction.new(account_id: 33, amount: debit_amount) }
          before { [transaction, debit_transaction].each { |t| Lannister.transaction_repo.persist(t) } }

          it 'ignores them' do
            expect(execute).to eq(amount)
          end
        end
      end
    end
  end
end
