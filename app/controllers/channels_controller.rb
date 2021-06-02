class ChannelsController < ApplicationController
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

  # GET /channels/new
  def new
    @channel = Channel.new
    respond_with(@channel)
  end

  # GET /channels/1/edit
  def edit
  end

  # POST /channels
  def create
    @channel = Channel.new(channel_params)

    @channel.save
    respond_with(@channel)
  end

  # PATCH/PUT /channels/1
  def update
    @channel.update(channel_params)
    respond_with(@channel)
  end

  # DELETE /channels/1
  def destroy
    @channel.destroy
    respond_with(@channel)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel
      @channel = Channel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def channel_params
      params.require(:channel).permit(:server_id, :uid, :properties)
    end
end
