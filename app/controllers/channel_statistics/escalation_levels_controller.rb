# frozen_string_literal: true

module ChannelStatistics
  class EscalationLevelsController < EscalationLevelsController
    before_action :set_escalatable

    private

    def set_escalatable
      @escalatable = ChannelStatistic.find(params[:channel_statistic_id])
    end

    def add_breadcrumb_show
      add_breadcrumb_for([@escalatable, @channel_statistic])
    end
  end
end
