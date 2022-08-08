# frozen_string_literal: true

class Connector::DiagramButtonComponent < ViewComponent::Base
  def initialize(connector:)
    @connector = connector
  end

  private 
  attr_reader :connector

  def filter
    if connector.type == 'RxConnector'
      { destination_connector_id: connector.id }
    else
      { source_connector_id: connector.id }
    end
  end

end
