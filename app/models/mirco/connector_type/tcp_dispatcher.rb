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
          "keepConnectionOpen": properties['keepConnectionOpen']
        }
      end

      def puml_text
        "tcp://#{remote_address}:#{remote_port}".html_safe
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
