class ExtendedInterfaceConnector
  attr_reader :interface_connector, :server_id
  delegate :id, :name, :type, :url, :sw_name, :if_name, :hostname, :ipaddress, 
           to: :interface_connector

  def initialize(interface_connector, options = {})
    @options = options.symbolize_keys
    @interface_connector = interface_connector
    @server_id = options.fetch(:server_id)
  end
end
