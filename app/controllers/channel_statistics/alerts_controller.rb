# frozen_string_literal: true

module ChannelStatistics
  class AlertsController < AlertsController
    before_action :set_alertable

    private

    def set_alertable
      @alertable = ChannelStatistic.find(params[:channel_statistic_id])
    end

    def add_breadcrumb_show
      add_breadcrumb_for([set_alertable, @alert])
    end

  end
end
