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
      return Result.new
    end
  end
end
