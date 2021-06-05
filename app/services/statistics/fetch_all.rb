module Statistics
  #
  # Service fetching all channels from one server via mirth api /channels
  #
  class FetchAll
    attr_reader :server
    Result = ImmutableStruct.new( :success?, :error_messages )

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
      @create_channel = options.fetch(:create_channel) { false }
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
                 error_messages: ["ERROR:: Login failed"]
               )
      end

      # fetch ChannelStatistics
      fetched = Wobmire::ChannelStatistic.fetch(mapi)

      # close session
      mapi.logout

      unless fetched.success?
        errmsgs << "ERROR:: fetching channel statistics failed"
        return Result.new(success: false, error_messages: errmsgs)
      end

     server.touch(:last_channel_update)

      # create server channels if neccessary
      fetched.channel_statistics.each do |stat|
        creator = Statistics::Creator.new(server: server, 
                                          attributes: stat.statistics,
                                          create_channel: create_channel )
        unless creator.save
          errmsgs << "ERROR:: could not create statistics for #{stat.statistics}"
          success = false
        end
      end

      return Result.new(success: success, error_messages: errmsgs)
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
