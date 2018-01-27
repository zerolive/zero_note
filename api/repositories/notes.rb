require_relative '../infrastructure/client'

module Repositories
  class Notes
    class << self
      def insert_one(note)
        client.insert_one(note.serialize)
        note
      end

      private

      def client
        Infrastructure::Client
      end
    end
  end
end
