# frozen_string_literal: true

class AcknowledgeButtonComponent < ViewComponent::Base
  # include Rails.application.routes.url_helpers
  def initialize(notable:, readonly: true, small: true)
    @notable = notable
    @readonly = readonly
    @type = 'acknowledge'
    @acknowledge = notable.acknowledge
    @small = small
  end

  def btn_size
    if small
      "btn-sm"
    else
      "btn"
    end
  end

  def button_css
    if @acknowledge.nil?
      "btn #{btn_size} btn-warning"
    else
      "btn #{btn_size} btn-outline-secondary"
    end
  end

  def button_action
    if @acknowledge.nil?
      new_polymorphic_path([notable, :note], type: type)
    else
      polymorphic_path([notable, acknowledge])
    end
  end

  def render?
    (!!acknowledge || !readonly) && error_state
  end

  private
  attr_reader :notable, :type, :readonly, :acknowledge, :small

  def error_state
    notable.condition >= Mirco::States::WARNING
  end

end
