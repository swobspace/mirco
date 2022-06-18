class SoftwareInterfacesController < ApplicationController
  before_action :set_software_interface, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /software_interfaces
  def index
    if @interfaceable
      @software_interfaces = @interfaceable.software_interfaces
    else
      @software_interfaces = SoftwareInterface.all
    end
    respond_with(@software_interfaces)
  end

  # GET /software_interfaces/1
  def show
    respond_with(@software_interface)
  end

  # GET /software_interfaces/new
  def new
    if @interfaceable
      @software_interface = @interfaceable.software_interfaces.build
    else
      @software_interface = SoftwareInterface.new
    end
    
    respond_with(@software_interface)
  end

  # GET /software_interfaces/1/edit
  def edit
  end

  # POST /software_interfaces
  def create
    if @interfaceable
      @software_interface = @interfaceable.software_interfaces.create(software_interface_params)
    else
      @software_interface = SoftwareInterface.new(software_interface_params)
    end

    @software_interface.save
    respond_with(@software_interface, location: location)
  end

  # PATCH/PUT /software_interfaces/1
  def update
    @software_interface.update(software_interface_params)
    respond_with(@software_interface, location: location)
  end

  # DELETE /software_interfaces/1
  def destroy
    @software_interface.destroy
    respond_with(@software_interface, location: location)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_software_interface
      @software_interface = SoftwareInterface.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def software_interface_params
      params.require(:software_interface)
            .permit(:software_id, :name, :hostname, :ipaddress, 
                    :description, :host_id)
    end

    def location
      polymorphic_path(@software_interface || :software_interfaces)
    end
end
