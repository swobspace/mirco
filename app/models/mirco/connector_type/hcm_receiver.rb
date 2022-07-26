# frozen_string_literal: true

module Mirco
  module ConnectorType
    class HcmReceiver < Generic
      def descriptor
        {
          "class": properties['class'],
          "fileAge": properties['fileAge'],
          "version": properties['version'],
          "fileName": properties['fileName'],
          "directory": properties['directory'],
          "statusName": properties['statusName'],
          "useLocking": properties['useLocking'],
          "checkFileAge": properties['checkFileAge'],
          "processBatch": properties['processBatch'],
          "useStatusFile": properties['useStatusFile'],
          "moveToFileName": properties['moveToFileName'],
          "charsetEncoding": properties['charsetEncoding'],
          "moveToDirectory": properties['moveToDirectory'],
          "createStatusFile": properties['createStatusFile'],
          "pluginProperties": properties['pluginProperties'],
          "errorReadingAction": properties['errorReadingAction'],
          "errorMoveToFileName": properties['errorMoveToFileName'],
          "errorMoveToDirectory": properties['errorMoveToDirectory'],
          "afterProcessingAction": properties['afterProcessingAction']
          # "pollConnectorProperties": properties['pollConnectorProperties'],
          # "sourceConnectorProperties": properties['sourceConnectorProperties']
        }
      end

      def puml_type
        'file'
      end

      def url
        'FILE:///' + "#{properties['directory']}/#{properties['fileName']}"
      end

      def puml_text
        url
      end

    end
  end
end
