# frozen_string_literal: true

class TdThresholdComponent < ViewComponent::Base
  def initialize(value:, warning:, critical:, alert: false, css: "")
    @value = value.to_i
    @warning = warning.to_i
    @critical = critical.to_i
    @alert = alert
    @css = css
    @background_color = background_color
  end

  private
  attr_reader :value, :warning, :critical, :alert, :css, :background_color

  def background_color
    if value >= critical
      if alert
        "bg-alert"
      else
        "bg-danger"
      end
    elsif value >= warning
      if alert
        "bg-alert"
      else
        "bg-warning"
      end
    else
      ""
    end
  end
end
