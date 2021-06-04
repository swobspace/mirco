class ChannelStatisticsController < ApplicationController
  before_action :set_channel_statistic, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /channel_statistics
  def index
    @channel_statistics = ChannelStatistic.all
    respond_with(@channel_statistics)
  end

  # GET /channel_statistics/1
  def show
    respond_with(@channel_statistic)
  end

  # GET /channel_statistics/new
  def new
    @channel_statistic = ChannelStatistic.new
    respond_with(@channel_statistic)
  end

  # GET /channel_statistics/1/edit
  def edit
  end

  # POST /channel_statistics
  def create
    @channel_statistic = ChannelStatistic.new(channel_statistic_params)

    @channel_statistic.save
    respond_with(@channel_statistic)
  end

  # PATCH/PUT /channel_statistics/1
  def update
    @channel_statistic.update(channel_statistic_params)
    respond_with(@channel_statistic)
  end

  # DELETE /channel_statistics/1
  def destroy
    @channel_statistic.destroy
    respond_with(@channel_statistic)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_channel_statistic
      @channel_statistic = ChannelStatistic.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def channel_statistic_params
      params.require(:channel_statistic).permit(:server_id, :channel, :server_uid, :channel_uid, :received, :sent, :error, :filtered, :queued)
    end
end
