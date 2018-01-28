require_relative '../services/notes'

module Actions
  class NotesForToday
    class << self
      def do
        notes = Services::Notes.for_today

        { 'notes' => notes }
      end
    end
  end
end
