# frozen_string_literal: true

class Puml::MultipleConnectionsConnectorComponent < ViewComponent::Base
  def initialize(connector:)
    @connector = connector
  end

  private
  attr_reader :connector

  def conn_identifier
    "connector_#{connector.id}"
  end

  def conn_text
    if connector.kind_of?(InterfaceConnector)
      raw("<size:16><b>#{connector.name}</b></size>" + '\n' +
          "<color:black>#{connector.sw_name} / #{connector.if_name}</color>" + '\n' +
          "<color:grey>#{connector.hostname} (#{connector.ipaddress})</color>")
    else
      "not configured"
    end
  end

  def conn_url
    if connector.kind_of?(InterfaceConnector)
      interface_connector_path(connector)
    else
      "#"
    end
  end

  def conn_color
    unless connector.kind_of?(InterfaceConnector)
      "#AAAAAA"
    end
  end

end
