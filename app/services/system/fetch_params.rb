module System
  #
  # Service fetching params from mirth api /server and /system
  #
  class FetchParams
    attr_reader :server
    Result = ImmutableStruct.new( :success?, :error_messages, :params )
    
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
      params = {}

      mapi = Wobmire::Api.new(server_options)
      # login
      unless mapi.login(server.api_user, server.api_password)
        return Result.new(
                 success: false, 
                 error_messages: ["ERROR:: Login failed"],
                 params: {}
               )
      end

      # fetch system info and stats
      sysinfo = Wobmire::SystemInfo.fetch(mapi)

      if sysinfo.success?
        params[:system_info] = sysinfo.info.info
      else
        errmsgs << "ERROR:: fetching sysinfo failed"
        success = false
      end

      return Result.new(
               success: success,
               error_messages: errmsgs,
               params: params
            )
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
