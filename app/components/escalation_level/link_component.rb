# frozen_string_literal: true

class EscalationLevel::LinkComponent < ViewComponent::Base
  with_collection_parameter :escalation_level

  def initialize(escalation_level:)
    @escalation_level = escalation_level
  end

  private
  attr_reader :escalation_level


  def name
    "#{escalation_level.attrib} / #{esc_name} / #{esc_type}"
  end

  def esc_name
    if escalation_level.escalatable_id == 0
      "default"
    elsif escalation_level.escalatable.respond_to?(:fullname)
      escalation_level.escalatable.fullname.to_s
    else
      escalation_level.escalatable.to_s
    end
  end

  def esc_type
    I18n.t(escalation_level.escalatable_type.underscore, scope: 'activerecord.models')
  end
end
