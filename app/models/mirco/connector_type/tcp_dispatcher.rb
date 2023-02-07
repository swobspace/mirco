# frozen_string_literal: true

module Mirco
  module ConnectorType
    class TcpDispatcher < Generic
      def descriptor
        {
          "remoteAddress": remote_address,
          "remotePort": remote_port,
          "localAddress": properties['localAddress'],
          "sendTimeout": properties['sendTimeout'],
          "responseTimeout": properties['responseTimeout'],
          "keepConnectionOpen": properties['keepConnectionOpen'],
          "charsetEncoding": properties['charsetEncoding']
        }
      end

      def url
        "tcp://#{remote_address}:#{remote_port}".html_safe
      end

      def puml_text
        url
      end

      private

      def remote_address
        properties['remoteAddress']
      end

      def remote_port
        properties['remotePort']
      end
    end
  end
end
