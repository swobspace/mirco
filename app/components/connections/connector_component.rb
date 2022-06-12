# frozen_string_literal: true

class Connections::ConnectorComponent < ViewComponent::Base
  def initialize(connector:)
    @connector = connector
  end

  def render?
    connector.present?
  end

  private
  attr_reader :connector

end
