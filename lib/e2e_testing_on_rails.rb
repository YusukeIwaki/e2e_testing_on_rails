# frozen_string_literal: true

require "e2e_testing_on_rails/version"

begin
  require 'simple_stub'
rescue LoadError
  # ignore
end

if defined?(Rails)
  require "e2e_testing_on_rails/eval_middleware"
  require "e2e_testing_on_rails/factory_bot_middleware" if defined?(FactoryBot)
  require "e2e_testing_on_rails/transaction_middleware"
  require "e2e_testing_on_rails/transaction_manager"
  require "e2e_testing_on_rails/railtie"
end
