# frozen_string_literal: true

module ChannelStatisticsGroups
  class EscalationLevelsController < EscalationLevelsController
    before_action :set_escalatable

    private

    def set_escalatable
      @escalatable ||= ChannelStatisticsGroup.find(params[:channel_statistics_group_id])
    end

    def add_breadcrumb_show
      add_breadcrumb_for([set_escalatable, @escalation_level])
    end
  end
end
