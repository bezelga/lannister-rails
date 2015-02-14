# This migration comes from accounting (originally 20150214194414)
class RenameTransactionsToTradesToAvoidConfusing < ActiveRecord::Migration
  def change
    rename_table :accounting_transactions, :accounting_trades
  end
end
