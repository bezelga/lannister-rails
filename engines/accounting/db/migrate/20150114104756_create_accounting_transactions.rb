class CreateAccountingTransactions < ActiveRecord::Migration
  def change
    create_table :accounting_transactions do |t|
      t.references :account, index: true
      t.decimal :amount
      t.date :date

      t.timestamps null: false
    end
    add_foreign_key :accounting_transactions, :accounts
  end
end
