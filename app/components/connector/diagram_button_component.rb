# frozen_string_literal: true

class Connector::DiagramButtonComponent < ViewComponent::Base
  def initialize(connector:, cssclass: "btn btn-secondary me-1")
    @connector = connector
    @cssclass = cssclass
  end

  private 
  attr_reader :connector, :cssclass

  def filter
    if connector.type == 'RxConnector'
      { destination_connector_id: connector.id }
    else
      { source_connector_id: connector.id }
    end
  end

end
