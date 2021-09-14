module Mirco
  module ConnectorType
    class TcpReceiver < Generic
      def descriptor
        {
          "serverMode": properties['serverMode'],
          "reconnectInterval": properties['reconnectInterval'],
          "keepConnectionOpen": properties['keepConnectionOpen'],
          "listenerIP": properties['listenerConnectorProperties']['host'],
          "listenerPort": properties['listenerConnectorProperties']['port'],
        }
      end
    end
  end
end
