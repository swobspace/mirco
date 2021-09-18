module Mirco
  module ConnectorType
    class VmDispatcher < Generic
      def descriptor
        if channel.present?
          {
            "writeToChannel": [
               channel.to_s,
               Rails.application.routes.url_helpers.server_channel_path(channel.server, channel)
            ]
          }
        else
          {
            "writeToChannel": "none"
          }
        end
      end
    private
      def channel
        Channel.where(uid: properties['channelId']).first
      end
    end
  end
end
