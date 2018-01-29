require_relative '../services/notes'

module Actions
  class MarkAsUndone
    class << self
      def do(id)
        undone_note = Services::Notes.mark_as_undone(id)

        undone_note
      end
    end
  end
end
