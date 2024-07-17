# frozen_string_literal: true

module ApplicationHelper
  include Wobapphelpers::Helpers::All

  def configuration_active_class
    if Mirco::CONFIGURATION_CONTROLLER.include?(controller.controller_name.to_s)
      "active"
    end
  end

  def software_active_class
    if Mirco::SOFTWARE_CONTROLLER.include?(controller.controller_name.to_s)
      "active"
    end
  end

  def servers_active_class
    if Mirco::SERVERS_CONTROLLER.include?(controller.controller_name.to_s)
      "active"
    end
  end

  def format(text, options = {})
    return '' if text.blank?

    options.symbolize_keys!
    style = options.fetch(:style, :markdown)
    case style
    when :markdown
      text = text.gsub('\n', "\n")
      Kramdown::Document.new(text).to_html.html_safe
    when :pre
      %(<pre>#{text}</pre>).html_safe
    else
      text
    end
  end

  def asciidoc_link(obj)
    if can? :read, obj
      link_to raw(%Q[<i class="fas fa-fw fa-file-code"></i>]),
              polymorphic_path(obj, format: :adoc),
              class: 'btn btn-secondary me-1',
              title: 'Asciidoc'
    end
  end

  def doku_link(obj)
    if can? :doku, obj
      link_to raw(%Q[<i class="fas fa-fw fa-file-code"></i>]),
              polymorphic_path([:doku, obj]),
              class: 'btn btn-secondary me-1',
              title: 'Documentation'
    end
  end
end
