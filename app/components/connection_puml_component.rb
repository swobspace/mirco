# frozen_string_literal: true

class ConnectionPumlComponent < ViewComponent::Base
  def initialize(connection:)
    @connection = connection
  end

  private

  attr_reader :connection

  def src
    connection.source_connector
  end

  def src_identifier
    if src
      "connection_#{src.id}"
    else
      "unknown_src_#{connection.id}"
    end
  end

  def src_text
    if src
      raw("<size:16><b>#{src.name}</b></size>" + '\n' +
          "<color:black>#{src.sw_name} / #{src.if_name}</color>" + '\n' +
          "<color:grey>#{src.hostname} (#{src.ipaddress})</color>")
    else
      "not configured"
    end
  end

  def src_url
    if src
      interface_connector_path(src)
    else
      '#'
    end
  end

  def src_color
    unless src
      "#AAAAAA"
    end
  end

  def dst
    connection.destination_connector
  end

  def dst_identifier
    if dst
      "connection_#{dst.id}"
    elsif connection.dst_url_host.present?
      "connection_#{connection.id}_host_#{connection.dst_url_host.id}"
    else
      "unknown_dst_#{connection.id}"
    end
  end

  def dst_text
    if dst
      raw("<size:16><b>#{dst.name}</b></size>" + '\n' +
          "<color:black>#{dst.sw_name} / #{dst.if_name}</color>" + '\n' +
          "<color:grey>#{dst.hostname} (#{dst.ipaddress})</color>")
    elsif connection.dst_url_host.present?
      raw("<size:16><b>#{connection.dst_url_host.name}</b></size>" + '\n' +
          "<color:black>#{connection.dst_url_host.ipaddress}</color>" + '\n' +
          "<color:black>#{connection.dst_url_host.software_group}</color>")
    else
      "not configured"
    end
  end

  def dst_url
    if dst
      interface_connector_path(dst)
    elsif connection.dst_url_host.present?
      host_path(connection.dst_url_host)
    else
      '#'
    end
  end

  def dst_color
    unless dst
      '#CCCCCC'
    end
  end


end
