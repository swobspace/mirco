# frozen_string_literal: true

module Mirco
  module ConnectorType
    class FileDispatcher < Generic
      def descriptor
        {
          "host": properties['host'],
          "scheme": properties['scheme'],
          "outputPattern": properties['outputPattern']
        }
      end

      def puml_type
        'file'
      end

      def puml_text
        "#{scheme}://#{host}/#{output_pattern}"
      end

      private

      def scheme
        properties['scheme']
      end

      def host
        properties['host']
      end

      def output_pattern
        properties['outputPattern']
      end
    end
  end
end
