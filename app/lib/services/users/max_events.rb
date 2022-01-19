# frozen_string_literal: true

module Services
  module Users
    class MaxEvents
      attr_accessor :max_count

      def self.call(max_count = 3)
        new(max_count).call
      end

      def initialize(max_count)
        @max_count = max_count
      end

      def call
        Queries::Users::MaxEvents.call(max_count)
      end
    end
  end
end
