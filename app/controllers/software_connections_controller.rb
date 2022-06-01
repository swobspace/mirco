class SoftwareConnectionsController < ApplicationController
  before_action :set_software_connection, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /software_connections
  def index
    @software_connections = SoftwareConnection.all
    respond_with(@software_connections)
  end

  # GET /software_connections/1
  def show
    respond_with(@software_connection)
  end

  # GET /software_connections/new
  def new
    @software_connection = SoftwareConnection.new
    respond_with(@software_connection)
  end

  # GET /software_connections/1/edit
  def edit
  end

  # POST /software_connections
  def create
    @software_connection = SoftwareConnection.new(software_connection_params)

    @software_connection.save
    respond_with(@software_connection)
  end

  # PATCH/PUT /software_connections/1
  def update
    @software_connection.update(software_connection_params)
    respond_with(@software_connection)
  end

  # DELETE /software_connections/1
  def destroy
    @software_connection.destroy
    respond_with(@software_connection)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_software_connection
      @software_connection = SoftwareConnection.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def software_connection_params
      params.require(:software_connection).permit(:source_connector_id, :source_url, :destination_connector_id, :destination_url, :ignore, :ignore_reason, :description)
    end
end
