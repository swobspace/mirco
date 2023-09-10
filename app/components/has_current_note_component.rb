# frozen_string_literal: true

class HasCurrentNoteComponent < ViewComponent::Base
  def initialize(notable:)
    @notable = notable
  end

private
  attr_reader :notable

  def info_icon
    return '' unless notable.respond_to?(:current_note)
    return '' unless notable.current_note.present?
    msg = %Q[
      <button type="button" class="btn btn-sm btn-warning my-0"
              data-controller="tooltip"
              data-bs-toggle="tooltip" 
              data-bs-html="false" 
              data-bs-title="#{current_note}">
        <i class="fas fa-fw fa-exclamation-circle"></i>
      </button>
    ].html_safe
  end

  def current_note
    note = notable.current_note
    "#{note.created_at.localtime.to_fs(:local)}/#{note.type}: #{note.message.to_plain_text}"
  end

end
