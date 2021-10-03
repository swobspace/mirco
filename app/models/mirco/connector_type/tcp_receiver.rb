module Mirco
  module ConnectorType
    class TcpReceiver < Generic
      def descriptor
        {
          "serverMode": properties['serverMode'],
          "reconnectInterval": properties['reconnectInterval'],
          "keepConnectionOpen": properties['keepConnectionOpen'],
          "listenerIP": listener_ip,
          "listenerPort": listener_port
        }
      end

      def puml(channel_id)
        {
          type: "interface",
          alias: "ch_#{channel_id}_src",
          text: "#{listener_ip}:<b>#{listener_port}</b>"
        }
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
