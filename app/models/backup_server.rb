class BackupServer
  attr_reader :server, :configuration

  def initialize(server)
    @server = server
    @configuration = nil
  end

  def create
    fetch_configuration && store_backup
  end

  private

  def fetch_configuration
    svc = System::FetchConfiguration.new(server: server)
    result = svc.call
    return false unless result.success?
    @configuration = result.configuration
  end

  def store_backup
    backup = @server.server_configurations.create
    backup.xmlfile.attach(io: StringIO.new(configuration),
                          filename: "#{configuration.to_s}.xml",
                          content_type: 'text/xml',
                          identify: false)
  end

end
