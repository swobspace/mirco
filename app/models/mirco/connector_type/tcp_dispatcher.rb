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
        }
      end

      def puml(channel_id)
        {
          alias: "ch_#{channel_id}_dst_#{properties['metaDataId']}",
          text: "<b>#{remote_address}</b>:#{remote_port}"
        }
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
