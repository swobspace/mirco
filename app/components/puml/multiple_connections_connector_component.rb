# frozen_string_literal: true

class Puml::MultipleConnectionsConnectorComponent < ViewComponent::Base
  with_collection_parameter :connector

  def initialize(connector:)
    @connector = connector
  end

  private
  attr_reader :connector

  def server_identifier
    "server_#{connector.server_id}"
  end

  def conn_identifier
    "connector_#{connector.id}"
  end

  def conn_text
    if connector.kind_of?(ExtendedInterfaceConnector)
      raw("<size:16><b>#{connector.name}</b></size>" + '\n' +
          "<color:black>#{connector.sw_name} / #{connector.if_name}</color>" + '\n' +
          "<color:grey>#{connector.hostname} (#{connector.ipaddress})</color>")
    else
      "not configured"
    end
  end

  def conn_url
    if connector.kind_of?(ExtendedInterfaceConnector)
      interface_connector_path(connector)
    else
      "#"
    end
  end

  def conn_color
    unless connector.kind_of?(ExtendedInterfaceConnector)
      "#AAAAAA"
    end
  end

end
