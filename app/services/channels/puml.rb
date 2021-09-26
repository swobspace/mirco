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

  private
end
