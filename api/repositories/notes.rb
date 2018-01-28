require_relative '../infrastructure/moment'
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

      def undone
        documents = client.undone

        notes = documents.map do |document|
          Note.from(document)
        end

        notes
      end

      def done_today
        documents = client.done(today)

        notes = documents.map do |document|
          Note.from(document)
        end

        notes
      end

      private

      def today
        Infrastructure::Moment.today
      end

      def client
        Infrastructure::Client
      end
    end
  end
end
