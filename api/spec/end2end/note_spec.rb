require_relative '../../infrastructure/client'
require_relative '../../infrastructure/moment'
require 'rspec'
require 'json'

describe 'Note' do

  before :each do
    Infrastructure::Client.drop
  end

  after :each do
    Infrastructure::Client.drop
  end

  it 'has a text and type' do
    note = { 'text' => 'any_text', 'type' => 'task' }

    post '/new_note', note

    expect(new_note['text']).to eq(note['text'])
    expect(new_note['type']).to eq(note['type'])
  end

  it 'has a default type' do
    default_type = 'task'
    note = { 'text' => 'any_text' }

    post '/new_note', note

    expect(new_note['text']).to eq(note['text'])
    expect(new_note['type']).to eq(default_type)
  end

  it 'has a creation date' do
    creation_date = '27-01-2017'
    allow(Infrastructure::Moment).to receive(:today).and_return(creation_date)
    note = { 'text' => 'any_text', 'type' => 'task' }

    post '/new_note', note

    expect(new_note['created_at']).to eq(creation_date)
  end

  it 'can have a due date' do
    due_date = '27-01-2017'
    note = { 'due_date' => due_date }

    post '/new_note', note

    expect(new_note['due_date']).to eq(due_date)
  end

  it 'can be done' do
    done_date = '27-01-2017'
    allow(Infrastructure::Moment).to receive(:today).and_return(done_date)
    id = 'an_id'
    note = { 'id' => id }
    created_note = Note.new(id: id)
    Infrastructure::Client.insert_one(created_note.serialize)

    post '/mark_as_done', note

    expect(new_note['done_date']).to eq(done_date)
  end

  it 'can be mark as undone' do
    id = 'an_id'
    note = { 'id' => id }
    created_note = Note.new(id: id, done_date: 'any_date')
    Infrastructure::Client.insert_one(created_note.serialize)

    post '/mark_as_undone', note

    expect(old_note['done_date']).to be_empty
  end

  it 'can update the text, due date and type' do
    id = 'an_id'
    new_attributes = {
      'id' => id,
      'text' => 'New text',
      'type' => 'New Type',
      'due_date' => 'New date'
    }
    created_note = Note.new(id: id)
    Infrastructure::Client.insert_one(created_note.serialize)

    post'/update_note', new_attributes

    expect(new_note['text']).to eq(new_attributes['text'])
    expect(new_note['type']).to eq(new_attributes['type'])
    expect(new_note['due_date']).to eq(new_attributes['due_date'])
  end

  def old_note
    new_note
  end

  def new_note
    JSON.parse(last_response.body)
  end
end
