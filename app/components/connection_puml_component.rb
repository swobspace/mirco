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
    "connection_#{src.id}"
  end

  def src_text
    src.to_s
  end

  def dst
    connection.destination_connector
  end

  def dst_identifier
    "connection_#{dst.id}"
  end

  def dst_text
    dst.to_s
  end

end
