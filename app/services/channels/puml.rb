module Channels
  #
  # Create Channel or retrieve from database and update properties
  #
  class Puml

    # puml = Channels::Puml(channel: <channel>)
    #
    # mandantory options:
    # * :channel  - channel object
    #
    def initialize(options = {})
      options.symbolize_keys
      @channel = options.fetch(:channel)
    end

    # just for prototyping
    # puml = Channels::Puml.new(channel: channel).call
    # puml.definitions = 
    #   source.type source.text as source.alias
    #   channel.type channel.text as channel.alias
    #   dest1.type dest1.text as dest1.alias
    #   dest2.type dest2.text as dest2.alias
    #   ...
    # puml.linking =  
    #  source.alias --> channel.alias
    #  channel.alias --> dest1.alias
    #  channel.alias --> dest2.alias
    #  ... 
    #   

    def call
    end

  private
end
