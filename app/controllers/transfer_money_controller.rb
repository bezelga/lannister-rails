class TransferMoneyController < ApplicationController
  before_action :load_accounts
  before_action :load_balance

  def new
  end

  def create
    if Lannister.transfer_money(source_account_id: source_account_id,
                                destination_account_id: destination_account_id,
                                amount: amount)
      redirect_to new_transfer_money_path
    else
      flash[:error] = 'Not enough money on the source account'
      render :new
    end
  end

  private

  def load_balance
    @balance = Lannister.get_balance(account_id: current_account_id)
  end

  def load_accounts
    @accounts = Accounting::Account.all.pluck('name, id')
  end

  def amount
    params[:transfer_money][:amount].to_f
  end

  def destination_account_id
    params[:transfer_money][:destination_account_id].to_i
  end

  def source_account_id
    params[:transfer_money][:source_account_id]
  end

  def current_account_id
    @_current_account_id ||= Accounting::Account.find_by_name('Lannister').try(:id)
  end
end
