# frozen_string_literal: true

module Mirco
  class Connector
    attr_reader :hash, :channel

    def initialize(hash, channel:)
      @hash = hash || {}
      @channel = channel
    end

    #
    # simple properties
    #

    def enabled
      hash['enabled']
    end

    def filter
      hash['filter']
    end

    def filter_elements
      if filter.present?
        filter['elements']
      else
        {}
      end
    end

    def mode
      hash['mode']
    end

    def name
      hash['name']
    end

    def meta_data_id
      hash['metaDataId']
    end

    def properties
      hash['properties'] || {}
    end

    def connector_class
      properties['class']
    end

    #
    # raw transformer data
    #
    def transformer
      hash['transformer']
    end

    #
    # raw elements data
    #
    def transformer_elements
      if transformer.present?
        transformer['elements']
      else
        {}
      end
    end

    #
    # migrated data
    #
    def transformers
      @transformers ||= fetch_transformers
    end

    def filters
      @filters ||= fetch_filters
    end

    # rubocop:disable Naming/MethodName
    def transportName
      hash['transportName']
    end
    # rubocop:enable Naming/MethodName

    def version
      hash['version']
    end

    def puml
      {
        type: connector_type.puml_type,
        text: connector_type.puml_text,
        destination_channel_id: connector_type.destination_channel_id
      }
    end

    #
    # complex properties
    #

    def connector_type
      variant.new(properties: properties, channel: channel)
    end

    delegate :descriptor, to: :connector_type

    private

    def fetch_transformers
      tarry = []
      return tarry if transformer_elements.nil?

      transformer_elements.each do |k, te|
        if te.is_a? Array
          tarry += te.map { |t| Mirco::Transformer.new(k, t) }
        else
          tarry << Mirco::Transformer.new(k, te)
        end
      end
      tarry
    end

    def fetch_filters
      tarry = []
      return tarry if filter_elements.nil?

      filter_elements.each do |k, te|
        if te.is_a? Array
          tarry += te.map { |t| Mirco::Filter.new(k, t) }
        else
          tarry << Mirco::Filter.new(k, te)
        end
      end
      tarry
    end


    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/MethodLength
    def variant
      case connector_class
      when 'com.mirth.connect.connectors.tcp.TcpReceiverProperties'
        Mirco::ConnectorType::TcpReceiver
      when 'com.mirth.connect.connectors.vm.VmReceiverProperties'
        Mirco::ConnectorType::VmReceiver
      when 'com.mirth.connect.connectors.file.FileReceiverProperties'
        Mirco::ConnectorType::FileReceiver
      when 'com.mirth.connect.connectors.js.JavaScriptReceiverProperties'
        Mirco::ConnectorType::JavascriptReceiver
      when 'com.mirth.connect.connectors.tcp.TcpDispatcherProperties'
        Mirco::ConnectorType::TcpDispatcher
      when 'com.mirth.connect.connectors.file.FileDispatcherProperties'
        Mirco::ConnectorType::FileDispatcher
      when 'com.mirth.connect.connectors.vm.VmDispatcherProperties'
        Mirco::ConnectorType::VmDispatcher
      when 'com.mirth.connect.connectors.js.JavaScriptDispatcherProperties'
        Mirco::ConnectorType::JavascriptDispatcher
      else
        Mirco::ConnectorType::Generic
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/MethodLength

  end
end
