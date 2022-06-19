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

      def url
        "#{scheme}://#{host}/#{output_pattern}"
      end

      def puml_text
        url
      end

      def puml_host
        uri = Mirco::Uri.new(url)
        if uri.host =~ /\A[0-9]{0,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\z/
          Host.where(ipaddress: uri.host).first
        else
          nil
        end
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
