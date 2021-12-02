# frozen_string_literal: true

class ChannelStatisticsController < ApplicationController
  before_action :set_channel_statistic, only: %i[show edit update destroy last_week today]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /channel_statistics
  def index
    @channel_statistics = if @server
                            @server.channel_statistics
                          else
                            ChannelStatistic.all
                          end
    respond_with(@channel_statistics)
  end

  # GET /channel_statistics/1
  def show
    respond_with(@channel_statistic)
  end

  #
  # endpoints for highchart
  #

  def last_week
    render json: @channel_statistic.channel_counters.last_week.per_hour.map { |x|
                   [x.time.localtime.strftime('%a %H:%M'), x.value]
                 }
  end

  def last_month
    render json: @channel_statistic.channel_counters.last_month.per_6hour.map { |x|
                   [x.time.localtime.strftime('%d.%m. %Hh'), x.value]
                 }
  end

  def today
    render json: @channel_statistic.channel_counters.today.per_15min.map { |x|
                   [x.time.localtime.strftime('%H:%M'), x.value]
                 }
  end

  def current
    render json: @channel_statistic.channel_counters.last_8h.per_5min.map { |x|
                   [x.time.localtime.strftime('%H:%M'), x.value]
                 }
  end

  def current_sent
    render json: @channel_statistic.channel_counters.last_8h.increase.map { |x|
                   [x.time.localtime.strftime('%H:%M'), x.delta]
                 }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_channel_statistic
    @channel_statistic = ChannelStatistic.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def channel_statistic_params
    params.require(:channel_statistic).permit(:server_id, :channel, :server_uid, :channel_uid, :received, :sent,
                                              :error, :filtered, :queued)
  end

  def location
    polymorphic_path(@server || @channel_statistic)
  end
end
