module E2eTestingOnRails
  class FactoryBotMiddleware
    def initialize(app)
      @app = app
    end

    def call(env)
      request = Rack::Request.new(env)
      if request.path == '/__e2e__/factory_bot/create'
        factory_name = request.params['name']
        attributes = JSON.parse(request.body.read) rescue nil
        object = if attributes.is_a?(Array)
          FactoryBot.create(factory_name, *attributes)
        elsif attributes.is_a?(Hash)
          FactoryBot.create(factory_name, **attributes)
        else
          FactoryBot.create(factory_name)
        end
        return [200, {'Content-Type' => 'application/json'}, [object.as_json.to_json]]
      end

      @app.call(env)
    end
  end
end
