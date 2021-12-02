# frozen_string_literal: true

module Mirco
  module ConnectorType
    class VmReceiver < Generic
      def descriptor
        {}
      end

      def puml_type
        'interface'
      end

      def puml_text
        'Channel Reader'
      end
    end
  end
end
