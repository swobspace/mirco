module Mirco
  class ChannelDiagram < Diagram

    def initialize(channel, options = {})
      @channel = channel
    end

    def render_puml
      ApplicationController.render(
        assigns: { channel: channel },
        template: 'channels/show',
        formats: [:puml],
        layout: false
      )
    end

    def basename
      "channel_#{channel.id}"
    end

    def type
      "channel"
    end

  private
    attr_reader :channel

  end
end
