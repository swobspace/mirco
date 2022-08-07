# frozen_string_literal: true

class Puml::MultipleConnectionsServerComponent < ViewComponent::Base
  with_collection_parameter :server

  def initialize(server:)
    @server = server
  end

  private
  attr_reader :server

  def srv_identifier
    "server_#{server.id}"
  end

  def srv_text
    raw("<size:16><b>#{server.name}</b></size>" + '\n' + "#{server.ipaddress}")
  end

  def srv_color
    # "#FFD080"
    "#FFD18C"
  end

end
