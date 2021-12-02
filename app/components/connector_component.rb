# frozen_string_literal: true

class ConnectorComponent < ViewComponent::Base
  def initialize(connector:)
    @connector = connector
    @mc = connector
  end

  def enabled
    if mc.enabled == 'true'
      'text-muted'
    else
      'fw-bolder text-danger'
    end
  end

  def render?
    connector.present? && mc.present?
  end

  def formatted(text, options)
    helpers.format(text, options)
  end

  private

  attr_reader :connector, :mc
end
