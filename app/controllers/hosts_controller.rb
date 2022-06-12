class HostsController < ApplicationController
  before_action :set_host, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /hosts
  def index
    @hosts = Host.all
    respond_with(@hosts)
  end

  # GET /hosts/1
  def show
    respond_with(@host)
  end

  # GET /hosts/new
  def new
    @host = Host.new
    respond_with(@host)
  end

  # GET /hosts/1/edit
  def edit
  end

  # POST /hosts
  def create
    @host = Host.new(host_params)

    @host.save
    respond_with(@host)
  end

  # PATCH/PUT /hosts/1
  def update
    @host.update(host_params)
    respond_with(@host)
  end

  # DELETE /hosts/1
  def destroy
    @host.destroy
    respond_with(@host)
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
end
