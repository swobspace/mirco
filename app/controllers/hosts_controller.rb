class HostsController < ApplicationController
  before_action :set_host, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /hosts
  def index
    if @location
      @hosts = @location.hosts
    else
      @hosts = Host.all
    end
    respond_with(@hosts)
  end

  # GET /hosts/1
  def show
    respond_with(@host)
  end

  # GET /hosts/new
  def new
    if @location
      @host = @location.hosts.build
    else
      @host = Host.new
    end
    respond_with(@host)
  end

  # GET /hosts/1/edit
  def edit
  end

  # POST /hosts
  def create
    if @location
      @host = @location.hosts.create(host_params)
    else
      @host = Host.new(host_params)
    end

    @host.save
    respond_with(@host, location: rlocation)
  end

  # PATCH/PUT /hosts/1
  def update
    @host.update(host_params)
    respond_with(@host, location: rlocation)
  end

  # DELETE /hosts/1
  def destroy
    @host.destroy
    respond_with(@host, location: rlocation)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_host
      @host = Host.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def host_params
      params.require(:host).permit(:location_id, :software_group_id, :name, :ipaddress, :description)
    end
    def rlocation
      polymorphic_path(@host || :hosts)
    end
end
