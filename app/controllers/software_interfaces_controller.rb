class SoftwareInterfacesController < ApplicationController
  before_action :set_software_interface, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /software_interfaces
  def index
    @software_interfaces = SoftwareInterface.all
    respond_with(@software_interfaces)
  end

  # GET /software_interfaces/1
  def show
    respond_with(@software_interface)
  end

  # GET /software_interfaces/new
  def new
    @software_interface = SoftwareInterface.new
    respond_with(@software_interface)
  end

  # GET /software_interfaces/1/edit
  def edit
  end

  # POST /software_interfaces
  def create
    @software_interface = SoftwareInterface.new(software_interface_params)

    @software_interface.save
    respond_with(@software_interface)
  end

  # PATCH/PUT /software_interfaces/1
  def update
    @software_interface.update(software_interface_params)
    respond_with(@software_interface)
  end

  # DELETE /software_interfaces/1
  def destroy
    @software_interface.destroy
    respond_with(@software_interface)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_software_interface
      @software_interface = SoftwareInterface.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def software_interface_params
      params.require(:software_interface).permit(:software_id, :name, :hostname, :ipaddress, :description)
    end
end
