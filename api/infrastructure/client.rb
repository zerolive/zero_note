require 'mongo'

module Infrastructure
  class Client
    class << self
      URI = "mongodb://mongo:27017/db"

      def insert_one(document)
        client[:notes].insert_one(document)
        client.close
        nil
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