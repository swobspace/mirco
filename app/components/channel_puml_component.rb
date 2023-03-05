# frozen_string_literal: true

class ChannelPumlComponent < ViewComponent::Base
  def initialize(channel:, scope: :channel)
    @channel = channel
    @scope   = scope
  end

  private

  attr_reader :channel, :scope

  def ch_alias
    channel.puml[:alias]
  end

  def source
    @channel.source_connector
  end

  def destinations
    @channel.destination_connectors.reject { |c| c.enabled == 'false' }
  end

  def render?
    channel.present? && source.present? && destinations.any?
  end
end
