class ChannelStatisticsController < ApplicationController
  before_action :set_channel_statistic, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /channel_statistics
  def index
    if @server
      @channel_statistics = @server.channel_statistics
    else
      @channel_statistics = ChannelStatistic.all
    end
    respond_with(@channel_statistics)
  end

  # GET /channel_statistics/1
  def show
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

    def location
      polymorphic_path(@server || @channel_statistic)
    end

end
