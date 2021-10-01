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
      hash['name']
    end

    def step
      hash['sequenceNumber']
    end

  end
end
