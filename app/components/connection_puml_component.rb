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
      src.to_s
    else
      "not configured"
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
      dst.to_s
    else
      "not configured"
    end
  end

  def dst_color
    unless dst
      "#AAAAAA"
    end
  end


end
