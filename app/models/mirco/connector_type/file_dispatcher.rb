# frozen_string_literal: true

module Mirco
  module ConnectorType
    class FileDispatcher < Generic
      def descriptor
        {
          "host": properties['host'],
          "scheme": properties['scheme'],
          "outputPattern": properties['outputPattern'],
          "charsetEncoding": properties['charsetEncoding']
        }
      end

      def puml_type
        'file'
      end

      def url
        "#{scheme}://#{host}/#{output_pattern}"
      end

      def puml_text
        url
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
