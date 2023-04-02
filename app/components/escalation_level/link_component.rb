# frozen_string_literal: true

class EscalationLevel::LinkComponent < ViewComponent::Base
  with_collection_parameter :escalation_level

  def initialize(escalation_level:)
    @escalation_level = escalation_level
  end

  private
  attr_reader :escalation_level

  def name
    escalation_level.to_s
  end
end
