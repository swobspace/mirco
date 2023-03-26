# frozen_string_literal: true

module EscalationStatusConcerns
  extend ActiveSupport::Concern

  included do
    unless defined?(EscalationResult)
      EscalationResult = ImmutableStruct.new(:state, :escalation_level)
    end
  end

  def escalation_status(attribs = [])
    attribs = Array(attribs)
    unless attribs.any?
      attribs = escalatable_attributes
    end
    state = EscalationLevel::NOTHING
    escalation_level = nil
    attribs.each do |attr|
      result = EscalationLevel.check_for_escalation(self, attr)
      if result.state > state
        state = result.state
        escalation_level = result.escalation_level
      end
    end
    return EscalationResult.new(state: state, escalation_level: escalation_level)
  end

end
