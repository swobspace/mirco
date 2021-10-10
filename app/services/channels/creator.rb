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
      if @uid.nil?
        raise ArgumentError, ":uid not specified and not in :properties"
      end
      @channel ||= fetch_channel
    end

    def save
      if @channel.nil? 
        @channel = server.channels.build(uid: uid, properties: properties)
      else
        @channel.properties = properties
      end
      if @channel.save 
        Mirco::ChannelDiagram.new(@channel).delete
        @channel.touch
      else
        Rails.logger.warn("WARN:: could not create or save channel #{@channel.uid}: " +
          @channel.errors.full_messages.join("; "))
        false
      end
    end

  private
    attr_reader :uid, :properties, :server

    def fetch_channel
      server.channels.where(server_id: server.id, uid: uid).first
    end

  end
end
