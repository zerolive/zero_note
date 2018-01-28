require_relative './actions/create_note'
require_relative './actions/mark_as_done'
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
      'type' => params['type'],
      'due_date' => params['due_date']
    }

    new_note = Actions::CreateNote.do(note)

    new_note.to_json
  end

  post '/mark_as_done' do

  done_note = Actions::MarkAsDone.do(params['id'])

  done_note.to_json
  end
end
