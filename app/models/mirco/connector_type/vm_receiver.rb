module Mirco
  module ConnectorType
    class VmReceiver < Generic
      def descriptor
        {}
      end

      def puml(channel_id)
        {
          alias: "interface_ch_#{channel_id}_src",
          text: "Channel Reader"
        }
      end
    end
  end
end
