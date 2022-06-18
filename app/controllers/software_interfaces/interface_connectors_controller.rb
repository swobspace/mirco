class SoftwareInterfaces::InterfaceConnectorsController < InterfaceConnectorsController
  before_action :set_software_interface

  private

  def set_software_interface
    @software_interface = SoftwareInterface.find(params[:software_interface_id])
  end

  def add_breadcrumb_show
    add_breadcrumb_for([set_software_interface, @interface_connector])
  end

  def location
    polymorphic_path(@software_interface)
  end
end
