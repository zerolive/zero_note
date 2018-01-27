require_relative '../services/notes'

module Actions
  class CreateNote
    class << self
      def do(note)
        new_note = Services::Notes.create(
          text: note['text'],
          type: note['type'],
          due_date: note['due_date']
        )

        new_note
      end
    end
  end
end
