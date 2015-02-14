# This migration comes from accounting (originally 20150114104626)
class CreateAccountingAccounts < ActiveRecord::Migration
  def change
    create_table :accounting_accounts do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
