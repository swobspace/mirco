class ServersController < ApplicationController
  before_action :set_server, only: [:show, :edit, :update, :update_properties, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /servers
  def index
    @servers = Server.all.decorate
    respond_with(@servers)
  end

  # GET /servers/1
  def show
    @server = @server.decorate
    respond_with(@server) do |format|
      format.puml {
        render format: :puml, layout: false
      }
      format.svg {
        diagram = Mirco::ServerDiagram.new(@server)
        send_file diagram.image(:svg), :filename => "#{@server.name}.svg",
                        :disposition => 'inline',
                        :type => 'image/svg+xml'
      }
    end
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

  def update_properties
    result = System::FetchParams.new(server: @server).call
    if result.success?
      @server.update(properties: result.params)
    else
      @server.errors.add(:base, :invalid)
    end
    respond_with(@server, action: :show)
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
      params.require(:server).permit(
        :name, :uid, :location, :description, 
        :api_url, :api_user, :api_password, 
        :api_user_has_full_access, :api_verify_ssl).compact_blank
    end

    # --- file stuff

    def filebase
      File.join( Rails.root, 'tmp', "server-#{@server.id}" )
    end

    def pumlfile
      "#{filebase}.puml"
    end

    def svgfile
      "#{filebase}.svg"
    end

end
