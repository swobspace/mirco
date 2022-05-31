class InterfaceConnectorsController < ApplicationController
  before_action :set_interface_connector, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /interface_connectors
  def index
    if @software_interface
      @interface_connectors = @software_interface.interface_connectors
    else
      @interface_connectors = InterfaceConnector.all
    end
    respond_with(@interface_connectors)
  end

  # GET /interface_connectors/1
  def show
    respond_with(@interface_connector)
  end

  # GET /interface_connectors/new
  def new
    if @software_interface
      @interface_connector = @software_interface.interface_connectors.build
    else
      @interface_connector = InterfaceConnector.new
    end
    respond_with(@interface_connector)
  end

  # GET /interface_connectors/1/edit
  def edit
  end

  # POST /interface_connectors
  def create
    @interface_connector = InterfaceConnector.new(interface_connector_params)

    @interface_connector.save
    respond_with(@interface_connector)
  end

  # PATCH/PUT /interface_connectors/1
  def update
    @interface_connector.update(interface_connector_params)
    respond_with(@interface_connector)
  end

  # DELETE /interface_connectors/1
  def destroy
    @interface_connector.destroy
    respond_with(@interface_connector)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interface_connector
      @interface_connector = InterfaceConnector.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def interface_connector_params
      params.require(:interface_connector)
            .permit(:software_interface_id, :type, :url, :description, :name)
    end
end
