require_relative '../../actions/create_note'
require_relative '../../services/notes'
require 'rspec'

describe 'Create Note' do
  it 'returns the note that is created' do
    note = { 'text' => 'any_text', 'type' => 'task' }
    allow(Services::Notes).to receive(:create).and_return(note)

    new_note = Actions::CreateNote.do(note)

    expect(new_note['text']).to eq(note['text'])
    expect(new_note['type']).to eq(note['type'])
  end
end
