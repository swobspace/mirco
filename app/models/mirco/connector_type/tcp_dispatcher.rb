module Mirco
  module ConnectorType
    class TcpDispatcher < Generic
      def descriptor
        {
          "remoteAddress": properties['remoteAddress'],
          "remotePort": properties['remotePort'],
          "localAddress": properties['localAddress'],
          "sendTimeout": properties['sendTimeout'],
          "responseTimeout": properties['responseTimeout'],
          "keepConnectionOpen": properties['keepConnectionOpen'],
        }
      end
    end
  end
end
