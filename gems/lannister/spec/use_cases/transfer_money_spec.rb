require 'spec_helper'

module Lannister
  module UseCases
    describe TransferMoney do
      describe '.transfer' do
        subject(:transfer) { described_class.transfer_money(source_account_id: source_account_id,
                                                            destination_account_id: destination_account_id,
                                                            amount: amount ) }
        let(:source_account_id) { 1 }
        let(:destination_account_id) { 2 }
        let(:amount) { 1_000 }

        def get_balance(account_id)
          Lannister.get_balance(account_id: account_id)
        end

        context 'when there is enough money on the source account' do
          let(:previous_transaction) { Entities::Transaction.new(account_id: source_account_id,
                                                               amount: amount) }

          before { Lannister.transaction_repo.persist(previous_transaction) }

          it 'debits the specified amount from source account' do
            expect{ transfer }.to change{ get_balance(source_account_id) }.by(- amount)
          end

          it 'credits the specific amount to destination account' do
            expect{ transfer }.to change{ get_balance(destination_account_id) }.by(amount)
          end
        end

        context 'there is not  enough money on source account' do
          it 'cancels the transfer by responding false' do
            expect(transfer).to eq(false)
          end

          it 'does not change the accounts balance' do
            expect{ transfer }.to_not change{ get_balance(source_account_id) }
            expect{ transfer }.to_not change{ get_balance(destination_account_id) }
          end
        end
      end
    end
  end
end
