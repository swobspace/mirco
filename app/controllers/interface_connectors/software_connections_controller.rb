class InterfaceConnectors::SoftwareConnectionsController < SoftwareConnectionsController
  before_action :set_interface_connector

  private

  def set_interface_connector
    @interface_connector = InterfaceConnector.find(params[:interface_connector_id])
  end

  def add_breadcrumb_show
    add_breadcrumb_for([set_interface_connector, @software_connection])
  end

  def location
    polymorphic_path(@interface_connector)
  end
end
