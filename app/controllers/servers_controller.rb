class ServersController < ApplicationController
  before_action :set_server, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /servers
  def index
    @servers = Server.all
    respond_with(@servers)
  end

  # GET /servers/1
  def show
    respond_with(@server)
  end

  # GET /servers/new
  def new
    @server = Server.new
    respond_with(@server)
  end

  # GET /servers/1/edit
  def edit
  end

  # POST /servers
  def create
    @server = Server.new(server_params)

    @server.save
    respond_with(@server)
  end

  # PATCH/PUT /servers/1
  def update
    @server.update(server_params)
    respond_with(@server)
  end

  # DELETE /servers/1
  def destroy
    @server.destroy
    respond_with(@server)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_server
      @server = Server.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def server_params
      params.require(:server).permit(:name, :uid, :location, :description, :api_url, :api_user, :api_password, :api_user_has_full_access, :properties)
    end
end
