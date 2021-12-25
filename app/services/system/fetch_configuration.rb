# frozen_string_literal: true

module System
  #
  # Fetch the server configuration, i.e. for backups
  #
  class FetchConfiguration
    attr_reader :server

    Result = ImmutableStruct.new(:success?, :configuration, :error_messages)

    # service = System::FetchConfiguration(server: server)
    #
    # mandantory options:
    # * :server  - server object
    #
    def initialize(options = {})
      options.symbolize_keys
      @server = options.fetch(:server)
    end

    # service.call()
    #
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Rails/SkipsModelValidations
    def call
      success = true
      errmsgs = []

      mapi = Wobmire::Api.new(server_options)

      # login
      unless mapi.login(server.api_user, server.api_password)
        return Result.new(success: false, 
                          configuration: nil, 
                          error_messages: ['ERROR:: Login failed'])
      end

      # fetch configuration
      response = mapi.get('server/configuration')

      # close session
      mapi.logout

      unless response.success?
        errmsgs << 'ERROR:: fetch configuration failed'
        return Result.new(success: false, configuration: nil, error_messages: errmsgs)
      end

      Result.new(success: success, configuration: response.body, error_messages: errmsgs)
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Rails/SkipsModelValidations

    private

    def server_options
      {
        url: server.api_url,
        ssl: { verify: server.api_verify_ssl }
      }
    end
  end
end
