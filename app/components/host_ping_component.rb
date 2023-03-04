# frozen_string_literal: true

class HostPingComponent < ViewComponent::Base
  def initialize(host:)
    @host = host
    @up   = host.up?
  end

  private
  attr_reader :host, :up

  def alert_class
    if up
      "alert-success"
    else
      "alert-danger"
    end
  end

  def alert_text
    if up
      "Host is reachable."
    else
      "Host is unreachable!"
    end
  end

end
