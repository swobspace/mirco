# frozen_string_literal: true

module Mirco
  module ConnectorType
    class VmDispatcher < Generic
      def descriptor
        if dest_channel.present?
          {
            "writeToChannel": [
              dest_channel.to_s,
              Rails.application.routes.url_helpers.channel_path(dest_channel)
            ]
          }
        else
          {
            "writeToChannel": 'none'
          }
        end
      end

      #
      # no object definition, only for linking
      #
      def puml_type
        'queue'
      end

      def puml_text
        if dest_channel.present?
          dest_channel.name.to_s
        else
          'none'
        end
      end

      def destination_channel_id
        dest_channel.present? ? dest_channel.id : nil
      end

      private

      def dest_channel
        Channel.where(uid: properties['channelId'], server_id: channel.server_id).first
      end
    end
  end
end
