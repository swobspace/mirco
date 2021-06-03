class ChannelsController < ApplicationController
  before_action :set_server
  before_action :set_channel, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /channels
  def index
    @channels = Channel.all
    respond_with(@channels)
  end

  # GET /channels/1
  def show
    respond_with(@channel)
  end

  def fetch_all
    result = Channels::FetchAll.new(server: @server).call
    unless result.success?
      @server.errors.add(:base, :invalid)
    end
    respond_with(@server, action: :show)
  end

  # DELETE /channels/1
  def destroy
    @channel.destroy
    respond_with(@channel, location: @server)
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_channel
    @channel = Channel.find(params[:id])
  end

  def set_server
    @server = Server.find(params[:server_id])
  end

  def add_breadcrumb_show
    add_breadcrumb_for([@server, @channel])
  end

  # Only allow a trusted parameter "white list" through.
  def channel_params
    params.require(:channel).permit(:server_id, :uid, :properties)
  end
    
end
