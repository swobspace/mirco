# frozen_string_literal: true

class TdThresholdComponent < ViewComponent::Base
  def initialize(value:, warning:, critical:, alert: false, css: '', manual_update: false)
    @value = value.to_i
    @warning = warning.to_i
    @critical = critical.to_i
    @alert = alert
    @css = css
    @background_color = background_color
    @manual_update = manual_update
  end

  private

  attr_reader :value, :warning, :critical, :alert, :css, :manual_update

  def background_color
    if value >= critical
      if manual_update
        'bg-light'
      elsif alert
        'bg-alert'
      else
        'bg-danger'
      end
    elsif value >= warning
      if manual_update
        'bg-light'
      elsif alert
        'bg-alert'
      else
        'bg-warning'
      end
    else
      ''
    end
  end
end
