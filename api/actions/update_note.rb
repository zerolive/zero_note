
module Actions
  class UpdateNote
    class << self
      def do(id, text, type, due_date)
        note = Services::Notes.update(id: id, text: text, type: type, due_date: due_date)

        note
      end
    end
  end
end
