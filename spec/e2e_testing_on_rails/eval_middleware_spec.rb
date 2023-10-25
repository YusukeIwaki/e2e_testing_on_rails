require 'json'
require 'rack'
require 'rack/test'
require "e2e_testing_on_rails/eval_middleware"

RSpec.describe E2eTestingOnRails::EvalMiddleware do
  include Rack::Test::Methods

  let(:target) do
    lambda do |env|
      [200, { 'Content-Type' => 'application/json' }, [ { success: true }.to_json ]]
    end
  end

  let(:app) do
    _target = target
    Rack::Builder.app do
      use E2eTestingOnRails::EvalMiddleware
      run _target
    end
  end

  it 'evaluates the code' do
    post '/__e2e__/eval', '3.times.map { |i| i + 1 }.sum'
    expect(last_response.body).to eq('6')
  end
end
