# frozen_string_literal: true

class ChannelStatisticsController < ApplicationController
  before_action :set_channel_statistic, only: %i[show last_week today]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /channel_statistics
  def index
    if @server
      @channel_statistics = @server.channel_statistics
    elsif params['recent_errors'].present?
      @channel_statistics = ChannelStatistic.where('error > 0')
                                            .where('meta_data_id > 0')
                                            .where("last_message_error_at > ?",
                                                   7.days.before(Date.current))
    elsif params['outdated'].present?
      @channel_statistics = outdated_statistics
    else
      @channel_statistics = ChannelStatistic.all
    end
    if params[:active]
      @channel_statistics = @channel_statistics.active.current
    end
    respond_with(@channel_statistics)
  end

  def queued
    @channel_statistics = ChannelStatistic.active.current.queued
    if params[:all]
     # full display
    elsif params[:acknowledged]
      @channel_statistics = @channel_statistics.acknowledged
    else
      @channel_statistics = @channel_statistics.not_acknowledged
    end
    ordered = @channel_statistics.order('channel_statistics.condition desc, channel_statistics.queued desc')
    @count = ordered.count
    @pagy, @channel_statistics = pagy(ordered, count: ordered.count)

    respond_with(@channel_statistics)
  end

  def problems
    @current = ChannelStatistic.active.current
    if params[:condition]
      @channel_statistics = @current.condition(params[:condition]).not_acknowledged
    elsif params[:acknowledged]
      @channel_statistics = @current.escalated.acknowledged
    else
      @channel_statistics = @current.escalated.not_acknowledged
    end
    ordered = @channel_statistics
              .order('channel_statistics.condition desc, channel_statistics.queued desc')
              .includes(channel: :server)
    @count = ordered.count
    @pagy, @channel_statistics = pagy(ordered, count: ordered.count)

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

  def delete_outdated
    outdated_statistics.destroy_all
    redirect_to channel_statistics_path(outdated: true)
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

  def outdated
    # (2*Mirco::grace_period).before(Time.current)
    1.day.before(Time.current)
  end

  def outdated_statistics
    @outdated_statistics =
      ChannelStatistic.where('channel_statistics.updated_at < ?', outdated)
                      .joins(:server)
                      .where('servers.manual_update = ?', false)
  end
end
