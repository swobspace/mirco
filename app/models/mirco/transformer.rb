module Mirco
  class Transformer
    attr_reader :type, :hash

    def initialize(type, hash)
      @type = type
      @hash = hash
    end

    # 
    # simple properties
    #

    def enabled
      hash['enabled']
    end

    def name
      hash['name'] || "no description"
    end

    def step
      hash['sequenceNumber']
    end

    def short_type
      m = type.match(/.*\.([A-Za-z]+)Step/)
      m[1]
    end

    def content
      case type
      when 'com.mirth.connect.plugins.javascriptstep.JavaScriptStep'
        hash['script']
      when 'com.mirth.connect.plugins.messagebuilder.MessageBuilderStep'
      else
        ""
      end
    end

  end
end
