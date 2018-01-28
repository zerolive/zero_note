require_relative '../../infrastructure/moment'
require_relative '../../infrastructure/client'
require 'rspec'

describe 'Notes' do

  before :each do
    Infrastructure::Client.drop
  end

  after :each do
    Infrastructure::Client.drop
  end

  it 'are requested for today' do
    allow(Infrastructure::Moment).to receive(:today).and_return(today)
    create_undone_note(today)
    create_undone_note(yesterday)
    create_done_note(today)
    create_done_note(yesterday)

    post '/notes_for_today'

    notes = JSON.parse(last_response.body)['notes']
    expect(notes.size).to eq(3)
  end

  def create_undone_note(day)
    note = {
      'id' => 'an_id',
      'text' => 'text',
      'type' => 'task',
      'created_at' => day,
      'due_date' => 'any_date',
      'done_date' => ''
    }

    Infrastructure::Client.insert_one(note)
  end

  def create_done_note(day)
    note = {
      'id' => 'an_id',
      'text' => 'text',
      'type' => 'task',
      'created_at' => day,
      'due_date' => 'any_date',
      'done_date' => day
    }

    Infrastructure::Client.insert_one(note)
  end

  def today
    '27-01-2017'
  end

  def yesterday
    '26-01-2017'
  end
end
