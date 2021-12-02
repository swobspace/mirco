# frozen_string_literal: true

module Mirco
  module ConnectorType
    class JavascriptReceiver < Generic
      def descriptor
        {
        }
      end

      def puml_type
        'frame'
      end

      def puml_text
        'javascript'
      end
    end
  end
end
