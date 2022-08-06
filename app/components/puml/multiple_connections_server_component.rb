# frozen_string_literal: true

class Puml::MultipleConnectionsServerComponent < ViewComponent::Base
  def initialize(server:)
    @server = server
  end

  private
  attr_reader :server

  def srv_identifier
    "server_#{server.id}"
  end

  def srv_text
    raw("<size:16><b>#{server.name}</b></size>" + '\n' +
        "<color:grey>#{server.hostname} (#{server.ipaddress})</color>")
  end

end
