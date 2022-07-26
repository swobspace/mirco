# frozen_string_literal: true

module Channels
  #
  # Create Channel or retrieve from database and update properties
  #
  class Creator
    attr_reader :channel

    # creator = Channels::Creator(server: server, properties: {})
    #
    # mandantory options:
    # * :server  - server object
    # * :properties  - server object
    #
    def initialize(options = {})
      options.symbolize_keys
      @server = options.fetch(:server)
      @properties = options.fetch(:properties)
      @uid = options.fetch(:uid) { @properties['id'] }
      raise ArgumentError, ':uid not specified and not in :properties' if @uid.nil?

      @channel ||= fetch_channel
    end

    # rubocop:disable Metrics/AbcSize, Rails/SkipsModelValidations
    def save
      if @channel.nil?
        @channel = server.channels.build(uid: uid, properties: properties)
      else
        @channel.properties = properties
      end

      if @channel.save
        Mirco::ChannelDiagram.new(@channel).delete
        create_connections(@channel)
        @channel.touch
      else
        Rails.logger.warn("WARN:: could not create or save channel #{@channel.uid}: " +
          @channel.errors.full_messages.join('; '))
        false
      end
    end
    # rubocop:enable Metrics/AbcSize, Rails/SkipsModelValidations

    private

    attr_reader :uid, :properties, :server

    def fetch_channel
      server.channels.where(server_id: server.id, uid: uid).first
    end

    # create connections only for channels with receiving data from extern
    #
    def create_connections(channel)
      if channel.enabled? && channel.source_connector.url.present?
        creator = Connections::Creator.new(channel: channel)
        creator.save
      end
    end
  end
end
