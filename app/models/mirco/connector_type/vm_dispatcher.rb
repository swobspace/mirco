module Mirco
  module ConnectorType
    class VmDispatcher < Generic
      def descriptor
        {
          "writeToChannel": Channel.where(uid: properties['channelId']).first.to_s,
        }
      end
    end
  end
end
