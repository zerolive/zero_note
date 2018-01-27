require 'date'

module Infrastructure
  class Moment
    class << self
      def today
        Date.today.strftime("%d-%m-%Y")
      end
    end
  end
end
