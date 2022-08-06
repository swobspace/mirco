# frozen_string_literal: true

class Puml::MultipleConnectionsComponent < ViewComponent::Base
  def initialize(connections:)
    @connections = Array(connections)
  end

  def call
    Puml::MultipleConnectionsServerComponent.with_collection(servers).render_in(view_context)
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
    []
  end

end
