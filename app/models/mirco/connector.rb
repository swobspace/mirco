# frozen_string_literal: true

module Mirco
  class Connector
    attr_reader :hash

    def initialize(hash)
      @hash = hash || {}
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
      hash['properties']
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

    def transportName
      hash['transportName']
    end

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
      ctype = Mirco::ConnectorType::Generic.new(properties).variant.new(properties)
    end

    def descriptor
      connector_type.descriptor
    end

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
  end
end
