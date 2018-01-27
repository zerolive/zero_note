require_relative '../repositories/notes'
require_relative '../domain/note'

module Services
  class Notes
    class << self
      def create(text:'', type:'', due_date:'')
        note = Note.new(text: text, type: type, due_date: due_date)

        new_note = Repositories::Notes.insert_one(note)
        new_note.serialize
      end
    end
  end
end
