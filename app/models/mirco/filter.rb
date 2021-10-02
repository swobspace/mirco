module Mirco
  class Filter
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

    def operator
      hash['operator']
    end

    def short_type
      m = type.match(/.*\.([A-Za-z]+)Rule/)
      m[1]
    end

    def content
      case type
      when 'com.mirth.connect.plugins.javascriptrule.JavaScriptRule'
        hash['script']
      when 'com.mirth.connect.plugins.rulebuilder.RuleBuilderRule'
        ['field', 'values', 'condition'].map do |attr|
          "#{attr}: #{hash[attr]}"
        end.join("\n")
      else
        ""
      end
    end

  end
end
