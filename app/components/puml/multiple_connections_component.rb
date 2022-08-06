# frozen_string_literal: true

class Puml::MultipleConnectionsComponent < ViewComponent::Base
  def initialize(connections:)
    @connections = Array(connections)
  end

  def call
    servers.each do |server| 
      Puml::MultipleConnectionsServerComponent.new(server: server).render_in(view_context)
    end
  end

  attr_reader :connections, :servers, :connectors

  def servers
    Server.where(id: server_ids)
  end

  def server_ids
    connections.map(&:server_id).sort.uniq
  end

  def connectors
    []
  end

end
