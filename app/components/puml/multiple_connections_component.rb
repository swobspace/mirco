# frozen_string_literal: true

class Puml::MultipleConnectionsComponent < ViewComponent::Base
  def initialize(connections:)
    @connections = Array(connections)
  end

  private
  attr_reader :connections, :servers, :connectors

  def servers
    Server.where(id: server_ids)
  end

  def server_ids
    connections.map(&:server_id).sort.uniq
  end

  def connectors
    connectors = []
    connections.each do |conn|
      if conn.source_connector.present?
        connectors << ExtendedInterfaceConnector.new(conn.source_connector, 
                                                     server_id: conn.server_id)
      else
        connectors << NullInterfaceConnector.new(type: 'TxConnector',
                                                 server_id: conn.server_id,
                                                 url: conn.source_url)
      end
      if conn.destination_connector.present?
        connectors << ExtendedInterfaceConnector.new(conn.destination_connector, 
                                                     server_id: conn.server_id)
      else
        connectors << NullInterfaceConnector.new(type: 'RxConnector',
                                                 server_id: conn.server_id,
                                                 url: conn.destination_url)
      end
    end
    connectors.uniq{|c| [c.type, c.url]}
  end

end
