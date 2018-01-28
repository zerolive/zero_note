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
    create_note_for_today
    create_done_note_for_today
    create_note_for_yesterday
    create_note_done_yesterday

    post '/notes_for_today'

    notes = JSON.parse(last_response.body)['notes']
    expect(notes.size).to eq(3)
  end

  def create_note_for_today
    note = {
      'id' => 'an_id',
      'text' => 'text',
      'type' => 'task',
      'created_at' => today,
      'due_date' => 'any_date',
      'done_date' => ''
    }

    Infrastructure::Client.insert_one(note)
  end

  def create_done_note_for_today
    note = {
      'id' => 'an_id',
      'text' => 'text',
      'type' => 'task',
      'created_at' => today,
      'due_date' => 'any_date',
      'done_date' => today
    }

    Infrastructure::Client.insert_one(note)
  end

  def create_note_for_yesterday
    note = {
      'id' => 'an_id',
      'text' => 'text',
      'type' => 'task',
      'created_at' => yesterday,
      'due_date' => 'any_date',
      'done_date' => ''
    }

    Infrastructure::Client.insert_one(note)
  end

  def create_note_done_yesterday
    note = {
      'id' => 'an_id',
      'text' => 'text',
      'type' => 'task',
      'created_at' => yesterday,
      'due_date' => 'any_date',
      'done_date' => yesterday
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
