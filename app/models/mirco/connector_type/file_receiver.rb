# frozen_string_literal: true

module Mirco
  module ConnectorType
    class FileReceiver < Generic
      def descriptor
        {
          "host": host,
          "scheme": scheme,
          "regex": properties['regex'],
          "binary": properties['binary'],
          "afterProcessingAction": properties['afterProcessingAction'],
          "fileFilter": file_filter
        }
      end

      def puml_type
        'file'
      end

      def puml_text
        "#{scheme}://#{host}/#{file_filter}"
      end

      private

      def scheme
        properties['scheme']
      end

      def host
        properties['host']
      end

      def file_filter
        properties['fileFilter']
      end

      def directory_recursion?
        properties['directoryRecursion'] == 'true'
      end
    end
  end
end
