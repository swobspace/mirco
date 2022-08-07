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
          "#{connector.sw_name}" + '\n' + "#{connector.if_name}")
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

  def host_identifier
    if connector.ipaddress.present?
      "host_#{connector.ipaddress.to_s.gsub(/\./, '_')}"
    else
      nil
    end
   
  end

  def host_text
    raw("#{connector.hostname}" + '\n' + "#{connector.ipaddress}")
  end

  def host_color
    "#7EFFEB"
  end

end
