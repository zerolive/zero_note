require_relative '../services/notes'

module Actions
  class MarkAsDone
    class << self
      def do(id)
        done_note = Services::Notes.mark_as_done(id)

        done_note
      end
    end
  end
end
