# frozen_string_literal: true

module ChannelStatistics
  class AlertsController < AlertsController
    before_action :set_channel_statistic

    private

    def set_channel_statistic
      @channel_statistic = ChannelStatistic.find(params[:channel_id])
    end

    def location
      channel_statistic_path(@channel)
    end
  end
end
