# frozen_string_literal: true

class ChannelPumlComponent < ViewComponent::Base
  def initialize(channel:, scope: :channel)
    @channel = channel
    @scope   = scope
  end

  private
  attr_reader :channel, :source, :destinations, :ch_alias

  def ch_alias
    channel.puml[:alias]
  end

  def source
    Mirco::Connector.new(@channel.sourceConnector)
  end

  def destinations
    @channel.destination_connectors
    .map{|c| Mirco::Connector.new(c) }
    .reject{|c| c.enabled == 'false'}
  end

end
