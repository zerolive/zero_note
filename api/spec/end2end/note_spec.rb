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

  def new_note
    JSON.parse(last_response.body)
  end
end
