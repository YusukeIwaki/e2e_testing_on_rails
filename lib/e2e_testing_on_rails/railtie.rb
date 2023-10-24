module E2eTestingOnRails
  class Railtie < ::Rails::Railtie
    initializer "e2e_testing_on_rails.append_middlewares" do |app|
      app.middleware.use E2eTestingOnRails::EvalMiddleware
      app.middleware.use E2eTestingOnRails::FactoryBotMiddleware if defined?(FactoryBot)
      app.middleware.use E2eTestingOnRails::TransactionMiddleware
    end
  end
end
