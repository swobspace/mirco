# frozen_string_literal: true

class ConnectorComponent < ViewComponent::Base
  def initialize(connector:)
    @connector = connector
    @mc = Mirco::Connector.new(connector)
  end
private
  attr_reader :connector, :mc
end
