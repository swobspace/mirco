# frozen_string_literal: true

module Mirco
  module ConnectorType
    class Generic
      attr_reader :properties, :channel

      def initialize(properties:, channel:)
        @properties = properties || {}
        raise ArgumentError, 'needs properties hash from source or destination connector' if properties['class'].empty?

        @channel = channel
      end

      def descriptor
        {}
      end

      def connector_class
        properties['class']
      end

      def puml_type
        'rectangle'
      end

      def puml_text
        'unknown'
      end

      def puml_host
        nil
      end

      def destination_channel_id
        nil
      end

      def url
        nil
      end
    end
  end
end
