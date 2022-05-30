class Software::SoftwareInterfacesController < SoftwareInterfacesController
  before_action :set_software

  private

  def set_software
    @software = Software.find(params[:software_id])
  end

  def add_breadcrumb_show
    add_breadcrumb_for([@software, @software_interface])
  end
end
