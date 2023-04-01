# frozen_string_literal: true

module ChannelStatisticGroups
  class EscalationLevelsController < EscalationLevelsController
    before_action :set_escalatable

    private

    def set_escalatable
      @escalatable ||= ChannelStatisticGroup.find(params[:channel_statistic_group_id])
    end

    def add_breadcrumb_show
      add_breadcrumb_for([set_escalatable, @escalation_level])
    end
  end
end
