module Mirco
  module ConnectorType
    class Generic
      attr_reader :properties, :variant
      def initialize(properties={})
        @properties = properties
        if properties['class'].empty?
          raise ArgumentError, "needs properties hash from source or destination connector"
        end
        @variant = set_variant || Mirco::ConnectorType::Generic
      end

      def descriptor
        {}
      end

      def connector_class
        properties['class']
      end

    private
      def set_variant
        case connector_class
        when 'com.mirth.connect.connectors.tcp.TcpReceiverProperties'
          Mirco::ConnectorType::TcpReceiver
        else
          nil
        end
      end
    end
  end
end
