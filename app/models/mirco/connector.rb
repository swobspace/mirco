module Mirco
  class Connector
    attr_reader :hash

    def initialize(hash)
      @hash = hash
    end

    def mode
      hash['mode']
    end

    def enabled
      hash['enabled']
    end

    def name
      hash['name']
    end

    def version
      hash['version']
    end

    def transportName
      hash['transportName']
    end

    def properties
      hash['properties']
    end

    def connector_type
      ctype = Mirco::ConnectorType::Generic.new(properties).variant.new(properties)
    end

    def descriptor
      connector_type.descriptor
    end

  end
end
