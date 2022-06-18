class Software::SoftwareInterfacesController < SoftwareInterfacesController
  before_action :set_interfaceable

  private

  def set_interfaceable
    @interfaceable = Software.find(params[:software_id])
  end

  def add_breadcrumb_show
    add_breadcrumb_for([set_interfaceable, @software_interface])
  end

  def location
    polymorphic_path(@interfaceable)
  end
end
