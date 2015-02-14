class RenameTransactionsToTradesToAvoidConfusing < ActiveRecord::Migration
  def change
    rename_table :accounting_transactions, :accounting_trades
  end
end
