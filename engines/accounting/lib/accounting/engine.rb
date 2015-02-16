require 'rails'
require 'active_record'
require_relative '../../app/repositories/accounting/trade_repo'


module Accounting
  class Engine < ::Rails::Engine
    isolate_namespace Accounting
  end
end
