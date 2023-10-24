module E2eTestingOnRails
  class EvalMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)
      case request.path
      when '/__e2e__/eval'
        code = request.body.read
        result = eval(code, TOPLEVEL_BINDING)
        return [200, {'Content-Type' => 'application/json'}, [result.to_json]]
      end

      @app.call(env)
    end
  end
end
