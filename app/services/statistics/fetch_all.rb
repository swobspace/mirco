# frozen_string_literal: true

module Statistics
  #
  # Service fetching all channels from one server via mirth api /channels
  #
  class FetchAll
    attr_reader :server

    Result = ImmutableStruct.new(:success?, :error_messages)

    # service = System::FetchParams(server: server)
    #
    # mandantory options:
    # * :server  - server object
    # optional:
    # * :create_channel: boolean
    #
    def initialize(options = {})
      options.symbolize_keys
      @server = options.fetch(:server)
      @create_channel = options.fetch(:create_channel, false)
    end

    # service.call()
    # do all the work here ;-)
    # fetching only, do not assign any value to server here
    #
    def call
      success = true
      errmsgs = []
      channels = []

      mapi = Wobmire::Api.new(server_options)
      # login
      unless mapi.login(server.api_user, server.api_password)
        return Result.new(
          success: false,
          error_messages: ['ERROR:: Login failed']
        )
      end

      # fetch ChannelStatistics
      response = mapi.get('channels/statuses')
      # close session
      mapi.logout

      unless response.success?
        errmsgs << 'ERROR:: fetching channel statuses failed'
        return Result.new(success: false, error_messages: errmsgs)
      end

      statuses = Mirco::DashboardStatus.parse_xml(response.body)

      # create server channels if neccessary
      statuses.each do |stat|
        # create statistics if meta_data_id == nil (channel itself)
        # or if > 0 (all connectors except source)
        next unless stat.meta_data_id.nil? || stat.meta_data_id > 0

        creator = Statistics::Creator.new(server: server,
                                          attributes: stat.attributes,
                                          create_channel: create_channel)
        unless creator.save
          errmsgs << "ERROR:: could not create statistics for #{stat.statistics}"
          success = false
        end
      end
      if success
        server.touch(:last_check, :last_check_ok)
      else
        server.touch(:last_check)
      end

      Result.new(success: success, error_messages: errmsgs)
    end

    private

    attr_reader :create_channel

    def server_options
      {
        url: server.api_url,
        ssl: { verify: server.api_verify_ssl }
      }
    end
  end
end
