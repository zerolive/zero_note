require 'securerandom'

module Infrastructure
  class Random
    class << self
      def id
        SecureRandom.uuid
      end
    end
  end
end
