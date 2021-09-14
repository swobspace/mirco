# frozen_string_literal: true

class ConnectorComponent < ViewComponent::Base
  def initialize(connector:)
    @connector = connector
    @mc = Mirco::Connector.new(connector)
  end

  def enabled
    unless mc.enabled
      "text-danger"
    end
  end

private
  attr_reader :connector, :mc

end
