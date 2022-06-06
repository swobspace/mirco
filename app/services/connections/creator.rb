require 'uri'
module Connections
  # takes one channel as start channel and creates
  # one or more connections from source to destination 
  # using source_url and destination_url as endpoint
  #
  class Creator
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
        software_connection = SoftwareConnection
                              .create_with(attributes['channel_ids'])
                              .find_or_create_by(attributes.except('channel_ids'))
        Mirco::ConnectionDiagram.new(software_connection).delete
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
          @connection_attributes << { location_id: location.id,
                                      source_url: source_url,
                                      channel_ids: channel_ids,
                                      destination_url: dst.url }
        elsif dst.destination_channel_id.present?
          ch = Channel.where(id: dst.destination_channel_id).first
          channel_ids << ch.id
          build_connection_attributes(ch, channel_ids)
        end
      end
    end

    def true_source_url(url)
      uri = URI(url)
      if uri.host == '0.0.0.0'
        uri.host = source_channel.host
      end
      uri.to_s
    end

  end
end
