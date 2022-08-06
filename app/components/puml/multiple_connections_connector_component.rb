# frozen_string_literal: true

class Puml::MultipleConnectionsConnectorComponent < ViewComponent::Base
  def initialize(connector:)
    @connector = connector
  end

end
