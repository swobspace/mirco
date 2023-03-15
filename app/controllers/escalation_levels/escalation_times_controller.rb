# frozen_string_literal: true

module EscalationLevels
  class EscalationTimesController < EscalationTimesController
    before_action :set_escalation_level

    private

    def set_escalation_level
      @escalation_level = EscalationLevel.find(params[:escalation_level_id])
    end

    def add_breadcrumb_show
      add_breadcrumb_for([set_escalation_level, @escalation_time])
    end
  end
end
