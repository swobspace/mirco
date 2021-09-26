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

      #
      # no object definition, only for linking
      #
      def puml(channel_id)
        {
          type: nil,
          alias: "ch_#{channel.id}_src}",
          text: nil
        }

      end
    private
      def channel
        Channel.where(uid: properties['channelId']).first
      end
    end
  end
end
