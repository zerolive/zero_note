require 'sinatra/base'

class Api < Sinatra::Base
  set :bind, '0.0.0.0'

  get '/' do
    200
  end
end
