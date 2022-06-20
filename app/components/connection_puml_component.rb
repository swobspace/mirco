# frozen_string_literal: true

class ConnectionPumlComponent < ViewComponent::Base
  def initialize(connection:)
    @connection = connection
  end

  private

  attr_reader :connection

  def ch_alias
   connection.to_s 
  end

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
      raw("<size:16><b>#{src.name}</b></size>\n" +
          "<color:black>#{src.sw_name} / #{src.if_name}</color>\n" + 
          "<color:grey>#{src.hostname} (#{src.ipaddress})</color>")
    else
      "not configured"
    end
  end

  def src_url
    if src
      software_connection_path(src)
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
    else
      "unknown_dst_#{connection.id}"
    end
  end

  def dst_text
    if dst
      raw("<size:16><b>#{dst.name}</b></size>\n" +
          "<color:black>#{dst.sw_name} / #{dst.if_name}</color>\n" + 
          "<color:grey>#{dst.hostname} (#{dst.ipaddress})</color>")
    else
      "not configured"
    end
  end

  def dst_url
    if dst
      software_connection_path(dst)
    else
      '#'
    end
  end

  def dst_color
    unless dst
      "#AAAAAA"
    end
  end


end
