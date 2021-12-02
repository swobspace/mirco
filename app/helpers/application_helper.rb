module ApplicationHelper
  include Wobapphelpers::Helpers::All

  def format(text, options = {})
    return '' if text.blank?

    options.symbolize_keys!
    style = options.fetch(:style) { :markdown }
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
end
