# frozen_string_literal: true

class Servers::ObsoleteChannelsButtonComponent < ViewComponent::Base
  attr_reader :server

  def initialize(server:)
    @server = server
  end

  def render?
    obsolete_channels_count > 0
  end

  def obsolete_channels_count
    server.obsolete_channels.count
  end
end
