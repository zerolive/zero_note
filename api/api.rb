require_relative './actions/notes_for_today'
require_relative './actions/mark_as_undone'
require_relative './actions/mark_as_done'
require_relative './actions/create_note'
require_relative './actions/update_note'
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

  post '/notes_for_today' do

    notes = Actions::NotesForToday.do

    notes.to_json
  end

  post '/mark_as_undone' do
    id = params['id']

    note = Actions::MarkAsUndone.do(id)

    note.to_json
  end

  post '/update_note' do
    id = params['id']
    text = params['text']
    type = params['type']
    due_date = params['due_date']

    note = Actions::UpdateNote.do(id, text, type, due_date)

    note.to_json
  end
end
