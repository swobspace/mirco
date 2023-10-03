# frozen_string_literal: true

class HostPingComponent < ViewComponent::Base
  def initialize(host:)
    @host = host
    @up   = host.up?
  end

  private
  attr_reader :host, :up, :level, :message

  def level
    if up
      "info"
    else
      "danger"
    end
  end

  def message
    if up
      "Host is reachable."
    else
      "Host is unreachable!"
    end
  end

end
