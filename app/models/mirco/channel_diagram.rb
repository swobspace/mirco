# frozen_string_literal: true

module Mirco
  class ChannelDiagram < Diagram
    def initialize(channel, _options = {})
      @channel = channel
      @channels =_options.fetch(:channels, [@channel])
    end

    def render_puml
      ApplicationController.render(
        assigns: { channels: channels },
        template: 'channels/show',
        formats: [:puml],
        layout: false
      )
    end

    def basename
      "channel_#{channel.id}"
    end

    def type
      'channel'
    end

    private

    attr_reader :channel, :channels
  end
end
