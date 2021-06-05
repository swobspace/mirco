module Statistics
  #
  # Create Channel or retrieve from database and update attributes
  #
  class Creator

    # creator = Statistics::Creator(server: server, attributes: {})
    #
    # mandantory options:
    # * :server  - server object
    # * :attributes  - hash
    #
    def initialize(options = {})
      options.symbolize_keys
      @server = options.fetch(:server)
      @attributes = options.fetch(:attributes)
      @create_channel = options.fetch(:create_channel) { false }
      fetch_channel(@attributes['channelId']) 
      @channel_statistic ||= fetch_channel_statistic
    end

    def save
      if @channel_statistic.nil? 
        @channel_statistic = ChannelStatistic.new(
          server_id: server.id,
          channel_id: channel.id,
          server_uid: attributes['serverId'],
          channel_uid: attributes['channelId'],
          received: attributes['received'],
          sent: attributes['sent'],
          error: attributes['error'],
          filtered: attributes['filtered'],
          queued: attributes['queued'],
        )
      else
        @channel_statistic.assign_attributes(
          received: attributes['received'],
          sent: attributes['sent'],
          error: attributes['error'],
          filtered: attributes['filtered'],
          queued: attributes['queued'],
        )
      end
      @channel_statistic.save && @channel_statistic.touch
    end

  private
    attr_reader :attributes, :server, :channel, :create_channel

    def fetch_channel(uid)
      @channel ||= server.channels.where(uid: uid).first
      if @channel.nil? 
        if create_channel
          @channel = server.channels.create(uid: uid)
        else
          raise RuntimeError, "channel /#{@attributes['channelId']}/ does not exist"
        end
      end
    end

    def fetch_channel_statistic
      server.channel_statistics.where(
        server_id: server.id,
        channel_id: channel.id,
        server_uid: attributes['serverId'],
        channel_uid: attributes['channelId'],
      ).first
    end

  end
end
