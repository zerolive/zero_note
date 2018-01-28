require 'mongo'

module Infrastructure
  class Client
    class << self
      URI = "mongodb://mongo:27017/db"

      def insert_one(document={})
        client[:notes].insert_one(document)
        client.close
        nil
      end

      def find(id:'')
        query = { 'id' => id }
        document = client[:notes].find(id: id)
        client.close

        document.first
      end

      def update_one(id:'', document:{})
        return nil if id.empty?

        client[:notes].update_one(
          { id: id },
          '$set' => document
        )
        client.close

        nil
      end

      def undone
        documents = client[:notes].find(done_date: '')

        documents
      end

      def done(date)
        documents = client[:notes].find(done_date: date)

        documents
      end

      def drop
        client[:notes].drop
        client.close
        nil
      end

      private

      def client
        Mongo::Logger.logger.level = Logger::INFO

        @client ||= Mongo::Client.new(URI)
        @client
      end
    end
  end
end
