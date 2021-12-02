# frozen_string_literal: true

module Mirco
  module ConnectorType
    class VmDispatcher < Generic
      def descriptor
        if channel.present?
          {
            "writeToChannel": [
              channel.to_s,
              Rails.application.routes.url_helpers.channel_path(channel)
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
        if channel.present?
          channel.name.to_s
        else
          'none'
        end
      end

      def destination_channel_id
        channel.present? ? channel.id : nil
      end

      private

      def channel
        Channel.where(uid: properties['channelId']).first
      end
    end
  end
end
