# frozen_string_literal: true

module EscalationStatusConcerns
  extend ActiveSupport::Concern

  included do
    unless defined?(EscalationResult)
      EscalationResult = ImmutableStruct.new(:state, :escalation_level, :message)
    end
  end

  def escalation_status(attribs = [])
    msg_warn = []
    msg_crit = []
    message = []
    attribs = Array(attribs)
    unless attribs.any?
      attribs = escalatable_attributes
    end
    state = EscalationLevel::NOTHING
    escalation_level = nil
    attribs.each do |attr|
      result = EscalationLevel.check_for_escalation(self, attr)
      case result.state
        when EscalationLevel::CRITICAL
          msg_crit << attr.to_s
        when EscalationLevel::WARNING
          msg_warn << attr.to_s
      end
      if result.state > state
        state = result.state
        escalation_level = result.escalation_level
      end
    end
    if msg_crit.count > 0
      message << "CRITICAL(#{msg_crit.count}): " + msg_crit.join(", ")
    end
    if msg_warn.count > 0
      message << "WARNING(#{msg_warn.count}): " + msg_warn.join(", ")
    end
    return EscalationResult.new(state: state, escalation_level: escalation_level,
                                message: message.join("; "))
  end

end
