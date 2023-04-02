# frozen_string_literal: true

class EscalationLevel::EscalatableComponent < ViewComponent::Base
  def initialize(escalation_level:)
    @escalation_level = escalation_level
  end

  private
  attr_reader :escalation_level

  def esc_name
    if escalation_level.escalatable_id == 0
      "default"
    elsif escalation_level.escalatable.respond_to?(:fullname)
      link_to escalation_level.escalatable.fullname.to_s, escalation_level.escalatable
    else
      link_to escalation_level.escalatable
    end
  end

  def esc_type
    I18n.t(escalation_level.escalatable_type.underscore, scope: 'activerecord.models')
  end
end
