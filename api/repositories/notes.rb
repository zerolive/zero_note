require_relative '../infrastructure/client'
require_relative '../domain/note'

module Repositories
  class Notes
    class << self
      def insert_one(note)
        client.insert_one(note.serialize)
        note
      end

      def find(id:'')
        document = client.find(id: id)

        Note.from(document)
      end

      def update(note)
        document = note.serialize
        id = document['id']
        client.update_one(id: id, document: document)
      end

      private

      def client
        Infrastructure::Client
      end
    end
  end
end
