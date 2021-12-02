module Channels
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
    #
    def initialize(options = {})
      options.symbolize_keys
      @server = options.fetch(:server)
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

      # fetch Channels
      fetched = Wobmire::Channel.fetch(mapi)

      # close session
      mapi.logout

      unless fetched.success?
        errmsgs << 'ERROR:: fetching channels failed'
        return Result.new(success: false, error_messages: errmsgs)
      end

      server.touch(:last_channel_update)

      # create server channels if neccessary
      fetched.channels.each do |ch|
        creator = Channels::Creator.new(server: server, properties: ch.properties)
        unless creator.save
          errmsgs << "ERROR:: could not create channel #{ch.properties['id']}"
          success = false
        end
      end

      # delete old server diagrams
      Mirco::ServerDiagram.new(server).delete

      Result.new(success: success, error_messages: errmsgs)
    end

    private

    def server_options
      {
        url: server.api_url,
        ssl: { verify: server.api_verify_ssl }
      }
    end
  end
end
