class BackupServer
  attr_reader :server, :configuration

  def initialize(server)
    @server = server
    @configuration = nil
  end

  def create(server_configuration_params = {})
    fetch_configuration && store_backup(server_configuration_params)
  end

  private

  def fetch_configuration
    svc = System::FetchConfiguration.new(server: server)
    result = svc.call
    return false unless result.success?
    @configuration = result.configuration
  end

  def store_backup(server_configuration_params)
    backup = @server.server_configurations.create(server_configuration_params)
    backup.xmlfile.attach(io: StringIO.new(configuration),
                          filename: "#{configuration.to_s}.xml",
                          content_type: 'text/xml',
                          identify: false)
  end

end
