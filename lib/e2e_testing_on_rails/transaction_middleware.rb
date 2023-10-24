module E2eTestingOnRails
  class TransactionMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)
      case request.path
      when '/__e2e__/begin_transaction'
        TransactionManager.instance.begin_transaction
        return [200, {'Content-Type' => 'text/plain'}, ['OK']]
      when '/__e2e__/rollback_transaction'
        TransactionManager.instance.rollback_transaction
        return [200, {'Content-Type' => 'text/plain'}, ['OK']]
      end

      @app.call(env)
    end
  end
end
