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
      serversettings = Wobmire::ServerSettings.fetch(mapi)

      if sysinfo.success?
        params[:system_info] = sysinfo.info.info
      else
        errmsgs << "ERROR:: fetching sysinfo failed"
        success = false
      end

      if serversettings.success?
        params[:server_settings] = serversettings.settings.settings
      else
        errmsgs << "ERROR:: fetching server settings failed"
        success = false
      end

      # server_uid
      response = mapi.get("server/id")
      if response.success?
        params[:server_uid] = response.body.to_s
      else
        errmsgs << "ERROR:: fetching server id failed"
        success = false
      end

      # server_jvm
      response = mapi.get("server/jvm")
      if response.success?
        params[:server_jvm] = response.body.to_s
      else
        errmsgs << "ERROR:: fetching server jvm failed"
        success = false
      end

      # server_version
      response = mapi.get("server/version")
      if response.success?
        params[:server_version] = response.body.to_s
      else
        errmsgs << "ERROR:: fetching server version failed"
        success = false
      end

      # close session
      mapi.logout

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
