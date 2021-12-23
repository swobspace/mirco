class ServerConfigurationsController < ApplicationController
  before_action :set_server
  before_action :set_server_configuration, only: %i[show destroy]
  before_action :add_breadcrumb_show, only: [:show]

  def index
    @server_configurations = @server.server_configurations
    respond_with(@server_configurations)
  end

  def show
    send_data @server_configuration.xmlfile.download, 
              filename: "#{@server_configuration.to_s}.xml",
              disposition: 'attachment',
              type: 'application/xml'
  end

  def new
    @server_configuration = @server.server_configurations.build
    respond_with(@server_note)
  end

  def create
    backup = BackupServer.new(@server)
    respond_with(backup.configuration, location: location) do |format|
      if backup.create(server_configuration_params)
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_with(@server_configuration, location: location) do |format|
      if @server_configuration.destroy
        format.turbo_stream
      end
    end
  end

  private

  def server_configuration_params
    params.require(:server_configuration).permit(:comment)
  end

  def location
    server_url(@server, anchor: :server_configuration)
  end

  def set_server_configuration
    @server_configuration = ServerConfiguration.find(params[:id])
  end

  def set_server
    @server = Server.find(params[:server_id])
  end

  def add_breadcrumb_show
    add_breadcrumb_for([@server, @server_configuration])
  end

end
