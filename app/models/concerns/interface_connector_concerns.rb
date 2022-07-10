# frozen_string_literal: true

module InterfaceConnectorConcerns
  extend ActiveSupport::Concern

  included do
  end

  def direction
    case type
    when 'TxConnector'
      'out'
    when 'RxConnector'
      'in'
    else
      raise RuntimeError, "type #{type} not yet implemented"
    end
  end

  def software_connections
    case type
    when 'TxConnector'
      source_connections
    when 'RxConnector'
      destination_connections
    else
      raise RuntimeError, "type #{type} not yet implemented"
    end
  end

  def possible_connections
    connections = SoftwareConnection.where(location_id: location.id, ignore: false)
    case type
    when 'TxConnector'
      connections = connections.where(source_connector_id: nil, source_url: url)
    when 'RxConnector'
      connections = connections.where(destination_connector_id: nil, destination_url: url)
    else
      raise RuntimeError, "type #{type} not yet implemented"
    end
  end

  def nonlocal_possible_connections
    connections = SoftwareConnection.where('location_id != ?', location.id)
                                    .where(ignore: false)
    case type
    when 'TxConnector'
      connections = connections.where(source_connector_id: nil, source_url: url)
    when 'RxConnector'
      connections = connections.where(destination_connector_id: nil, destination_url: url)
    else
      raise RuntimeError, "type #{type} not yet implemented"
    end
  end
end
