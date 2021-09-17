# frozen_string_literal: true

class ConnectorComponent < ViewComponent::Base
  def initialize(connector:)
    @connector = connector
    @mc = Mirco::Connector.new(connector)
  end

  def enabled
    if mc.enabled == 'true'
      "text-muted"
    else
      "fw-bolder text-danger"
    end
  end

  def render?
    connector.present? && mc.present?
  end

private
  attr_reader :connector, :mc

end
