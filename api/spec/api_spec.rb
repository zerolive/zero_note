require_relative '../api'
require 'rack/test'
require 'rspec'

describe 'API' do
  include Rack::Test::Methods

  def app
    Api
  end

  it 'is up' do

    get '/'

    expect(last_response.status).to eq(200)
  end
end
