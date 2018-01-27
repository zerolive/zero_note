require_relative '../../infrastructure/client'
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

    new_note = JSON.parse(last_response.body)
    expect(new_note['text']).to eq(note['text'])
    expect(new_note['type']).to eq(note['type'])
  end

  it 'has a default type' do
    default_type = 'task'
    note = { 'text' => 'any_text' }

    post '/new_note', note

    new_note = JSON.parse(last_response.body)
    expect(new_note['text']).to eq(note['text'])
    expect(new_note['type']).to eq(default_type)
  end
end
