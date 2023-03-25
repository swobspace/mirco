# frozen_string_literal: true

module ServerConcerns
  extend ActiveSupport::Concern

  included do
    EscalationResult = ImmutableStruct.new(:state, :escalation_level)
  end

  def active_channels
    if last_channel_update.nil?
      channels
    else
      channels.where('channels.updated_at >= ?', 1.minute.before(last_channel_update))
    end
  end

  def obsolete_channels
    if last_channel_update.nil?
      channels.none
    else
      channels.where('channels.updated_at <= ?', 1.hour.before(last_channel_update))
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
