module Mirco
  module ConnectorType
    class FileDispatcher < Generic
      def descriptor
        {
          "host": properties['host'],
          "scheme": properties['scheme'],
          "outputPattern": properties['outputPattern'],
        }
      end
    end
  end
end
