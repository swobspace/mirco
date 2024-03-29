# frozen_string_literal: true

module Mirco
  module ConnectorType
    class Generic
      attr_reader :properties, :channel

      def initialize(properties:, channel:)
        @properties = properties || {}
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
        uri = Mirco::Uri.new(url)
        if uri.host =~ /\A[0-9]{0,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\z/
          Host.where(ipaddress: uri.host).first
        else
          nil
        end
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
