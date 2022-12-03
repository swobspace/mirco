# frozen_string_literal: true

class TdEscalationComponent < ViewComponent::Base
  def initialize(escalatable:, attrib:, alert: false, css: '', manual_update: false)
    @escalatable = escalatable
    @attrib = attrib
    @alert = alert
    @css = css
    @manual_update = manual_update
    @background_color = background_color
    @value = escalatable.send(attrib)
    if escalatable.send(attrib).kind_of? Time
      @value = escalatable.send(attrib)&.to_fs(:local)
    end
  end

  private

  attr_reader :escalatable, :attrib, :value, :alert, :css, :manual_update

  def background_color
    if manual_update
      'bg-light'
    else
      result = EscalationLevel.check_for_escalation(escalatable, attrib)
      case result
      when 3
        'bg-UNKNOWN'
      when 0
        'bg-OK'
      when 1
        alert ? 'bg-ALERT' : 'bg-WARN'
      when 2
        alert ? 'bg-ALERT' : 'bg-CRITICAL'
      end
    end
  end


end
