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

      def mark_as_done(id)
        note = Repositories::Notes.find(id: id)

        note.mark_as_done
        Repositories::Notes.update(note)

        note.serialize
      end

      def mark_as_undone(id)
        note = Repositories::Notes.find(id: id)

        note.mark_as_undone
        Repositories::Notes.update(note)

        note.serialize
      end

      def for_today
        undone = Repositories::Notes.undone
        created_today = Repositories::Notes.done_today

        undone + created_today
      end

      def update(id: id, text: text, type: type, due_date: due_date)
        note = Repositories::Notes.find(id: id)
        note.new_text(text)
        note.new_type(type)
        note.new_due_date(due_date)
        Repositories::Notes.update(note)

        note.serialize
      end
    end
  end
end
