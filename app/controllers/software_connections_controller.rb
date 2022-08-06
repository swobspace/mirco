class SoftwareConnectionsController < ApplicationController
  before_action :set_software_connection, only: [:show, :edit, :update, :destroy]
  # before_action :add_breadcrumb_show, only: [:show]

  # GET /software_connections
  def index
    if @interface_connector
      @software_connections = @interface_connector.software_connections
    else
      @software_connections = SoftwareConnection.all
    end
    if search_params.any?
      @software_connections = Connections::Query.new(@software_connections, search_params).all
    end
    respond_with(@software_connections) do |format|
      format.html do
        add_breadcrumb_index
      end
      format.puml do
        render format: :puml, layout: false
      end
      format.svg do
        diagram = Mirco::ConnectionsDiagram.new(@software_connections)
        send_file diagram.image(:svg), filename: "connections.svg",
                                       disposition: 'inline',
                                       type: 'image/svg+xml'
      end

    end
  end

  def search
  end

  # GET /software_connections/1
  def show
    respond_with(@software_connection) do |format|
      format.html do
        add_breadcrumb_show
      end
      format.puml do
        render format: :puml, layout: false
      end
      format.svg do
        diagram = Mirco::ConnectionDiagram.new(@software_connection)
        send_file diagram.image(:svg), filename: "connection-#{@software_connection.id}.svg",
                                       disposition: 'inline',
                                       type: 'image/svg+xml'
      end

    end
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
    respond_with(@software_connection, location: location)
  end

  # PATCH/PUT /software_connections/1
  def update
    @software_connection.update(software_connection_params)
    respond_with(@software_connection, location: location)
  end

  # DELETE /software_connections/1
  def destroy
    @software_connection.destroy
    respond_with(@software_connection, location: location)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_software_connection
      @software_connection = SoftwareConnection.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def software_connection_params
      params.require(:software_connection).permit(
        :location_id, :server_id,
        :source_connector_id, :source_url, 
        :destination_connector_id, :destination_url, 
        :ignore, :ignore_reason, :description
      )
    end

    def search_params
      searchparms = params.permit(*submit_parms, *non_search_params,
        :source_url, :destination_url, :source_connector_id, :destination_connector_id,
        :location_id, :ignore, :ignore_reason, :description, :channel_id,
        :id, :limit, :missing_connector).to_h
      searchparms.reject do |k, v|
        v.blank? || submit_parms.include?(k) || non_search_params.include?(k)
      end
   end

    def location
      polymorphic_path(@software_connection || :software_connections)
    end

    def submit_parms
      [ "utf8", "authenticity_token", "commit", "format", "view" ]
    end

    def non_search_params
      [ "interface_connector_id" ]
    end

end
