require 'uri'
module Connections
  # takes one channel as start channel and creates
  # one or more connections from source to destination 
  # using source_url and destination_url as endpoint
  #
  class Creator
    FIND_ATTRIBUTES = %w[location_id source_url destination_url]
    attr_reader :connection_attributes

    def initialize(channel:)
      @source_channel = channel
      @source_url = check_source
      @location = source_channel.location
      @connection_attributes = []
    end

    def save
      build_connection_attributes(source_channel, [source_channel.id])
      connection_attributes.each do |attributes|
        find_attributes = attributes.slice(*FIND_ATTRIBUTES)
        create_with_attributes = attributes.except(*FIND_ATTRIBUTES)
        software_connection = SoftwareConnection
                              .create_with(attributes)
                              .find_or_create_by(find_attributes)
        Mirco::ConnectionDiagram.new(software_connection).delete
        attributes.each_pair do |key,value|
          unless software_connection.send(key) == value
            software_connection.update(key => value)
          end
        end
      end
    end

  private
    attr_reader :source_channel, :location, :source_url

    def check_source
      if source_channel.source_connector.url.nil?
        raise RuntimeError, "Source Connector #{source_channel.source_connector} not processable"
      else
        true_source_url(source_channel.source_connector.url)
      end
    end

    def build_connection_attributes(channel, channel_ids)
      return if channel.nil?
      channel.destination_connectors.each do |dst| 
        next if dst.enabled == 'false'
        if dst.url.present?
          @connection_attributes << { 'location_id' => location.id,
                                      'source_url' => source_url,
                                      'server_id' => channel.server_id,
                                      'channel_ids'=> channel_ids,
                                      'destination_url' => dst.url }
        elsif dst.destination_channel_id.present?
          ch = Channel.where(id: dst.destination_channel_id).first
          build_connection_attributes(ch, channel_ids + [ch.id] )
        end
      end
    end

    def true_source_url(url)
      uri = URI(url)
      if (uri.host == '0.0.0.0' || uri.host == 'localhost' || uri.host == '127.0.0.1') and source_channel.ipaddress.present?
          uri.host = source_channel.ipaddress.to_s
      end
      uri.to_s
    end

  end
end
