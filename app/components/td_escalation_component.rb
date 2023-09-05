# frozen_string_literal: true

class TdEscalationComponent < ViewComponent::Base
  def initialize(escalatable:, attrib:, alert: false, css: '', manual_update: false)
    @escalatable = escalatable
    @attrib = attrib
    @alert = alert
    @css = css
    @manual_update = manual_update
    @value = escalatable.send(attrib)
    if escalatable.send(attrib).kind_of? Time
      @value = escalatable.send(attrib)&.to_fs(:local)
    end
    @escalation_status = escalatable.escalation_status(attrib)
    @background_color = background_color
  end

  private

  attr_reader :escalatable, :attrib, :value, :alert, :css, :manual_update, :escalation_status

  def background_color
    if manual_update
      'bg-light'
    else
      result = escalation_status.state
      case result
      when EscalationLevel::UNKNOWN
        'bg-UNKNOWN'
      when EscalationLevel::OK
        'bg-OK'
      when EscalationLevel::WARNING
        alert ? 'bg-ALERT' : 'bg-WARN'
      when EscalationLevel::CRITICAL
        alert ? 'bg-ALERT' : 'bg-CRITICAL'
      else
        ''
      end
    end
  end

  def info_icon
    return unless escalatable.respond_to?(:current_note)
    return unless escalatable.current_note.present?
    unless manual_update
      result = escalation_status.state
      case result
      when EscalationLevel::WARNING, EscalationLevel::CRITICAL
        msg = %Q[
          <button type="button" class="btn btn-sm text-white"
                  data-controller="tooltip"
                  data-bs-toggle="tooltip" 
                  data-bs-html="false" 
                  data-bs-title="#{current_note}">
            <i class="fas fa-info-circle"></i>
          </button>
        ].html_safe
      else
        ''
      end
    end
  end

  def current_note
    note = escalatable.current_note
    "#{note.created_at.localtime.to_fs(:local)}/#{note.type.upcase}: #{note.message.to_plain_text}"
  end
end
