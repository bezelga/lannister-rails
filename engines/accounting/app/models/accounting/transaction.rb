module Accounting
  class Transaction < ActiveRecord::Base
    belongs_to :account
  end
end
