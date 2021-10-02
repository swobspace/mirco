module ApplicationHelper
  include Wobapphelpers::Helpers::All

  def format(text)
    return "" if text.blank?
    Kramdown::Document.new(text).to_html.html_safe
  end
end
