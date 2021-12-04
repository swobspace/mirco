# frozen_string_literal: true

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
      raise 'Statistics::Creator.new: :attributes is empty!' if @attributes.empty?

      @create_channel = options.fetch(:create_channel, false)
      fetch_channel(@attributes['channel_uid'])
      @channel_statistic ||= fetch_channel_statistic
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Rails/SkipsModelValidations
    def save
      return false if channel.nil?

      if @channel_statistic.nil?
        @channel_statistic = ChannelStatistic.new(
          server_id: server.id,
          channel_id: channel.id,
          server_uid: server.uid,
          channel_uid: attributes['channel_uid'],
          meta_data_id: attributes['meta_data_id'],
          name: attributes['name'],
          state: attributes['state'],
          status_type: attributes['status_type'],
          received: attributes['received'],
          sent: attributes['sent'],
          error: attributes['error'],
          filtered: attributes['filtered'],
          queued: attributes['queued']
        )
      else
        @channel_statistic.assign_attributes(
          name: attributes['name'],
          state: attributes['state'],
          status_type: attributes['status_type'],
          received: attributes['received'],
          sent: attributes['sent'],
          error: attributes['error'],
          filtered: attributes['filtered'],
          queued: attributes['queued']
        )
      end

      channel_counter = @channel_statistic.channel_counters.build(
        server_id: server.id,
        channel_id: channel.id,
        meta_data_id: attributes['meta_data_id'],
        received: attributes['received'],
        sent: attributes['sent'],
        error: attributes['error'],
        filtered: attributes['filtered'],
        queued: attributes['queued']
      )
      @channel_statistic.save && @channel_statistic.touch && channel_counter.save
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Rails/SkipsModelValidations

    private

    attr_reader :attributes, :server, :channel, :create_channel

    def fetch_channel(uid)
      @channel ||= server.channels.where(uid: uid).first
      return unless @channel.nil? && create_channel

      @channel = server.channels.create(uid: uid)
      Rails.logger.warn("WARN:: #{server.name}: channel /#{@attributes['channel_uid']}/ does not exist")
    end

    def fetch_channel_statistic
      server.channel_statistics.where(
        server_id: server.id,
        channel_id: channel&.id,
        server_uid: server.uid,
        channel_uid: attributes['channel_uid'],
        meta_data_id: attributes['meta_data_id']
      ).first
    end
  end
end
