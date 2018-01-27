require 'rspec'

describe 'API' do
  it 'is up' do

    get '/'

    expect(last_response.status).to eq(200)
  end
end
