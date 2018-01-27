require_relative './actions/create_note'
require 'sinatra/base'
require 'json'

class Api < Sinatra::Base
  set :bind, '0.0.0.0'

  get '/' do
    200
  end

  post '/new_note' do
    note = {
      'text' => params['text'],
      'type' => params['type']
    }

    new_note = Actions::CreateNote.do(note)

    new_note.to_json
  end
end
