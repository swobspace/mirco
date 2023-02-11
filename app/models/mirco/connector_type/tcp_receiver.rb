# frozen_string_literal: true

module Mirco
  module ConnectorType
    class TcpReceiver < Generic
      def descriptor
        {
          "serverMode": properties['serverMode'],
          "reconnectInterval": properties['reconnectInterval'],
          "keepConnectionOpen": properties['keepConnectionOpen'],
          "listenerIP": listener_ip,
          "listenerPort": listener_port,
          "charsetEncoding": properties['charsetEncoding']
        }
      end

      def puml_type
        'interface'
      end

      def url
        "tcp://#{listener_ip}:#{listener_port}"
      end

      def puml_text
        url
      end

      private

      def listener_ip
        properties['listenerConnectorProperties']['host']
      end

      def listener_port
        properties['listenerConnectorProperties']['port']
      end
    end
  end
end
