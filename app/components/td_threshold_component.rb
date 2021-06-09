# frozen_string_literal: true

class TdThresholdComponent < ViewComponent::Base
  def initialize(value:, warning:, critical:, css: "")
    @value = value.to_i
    @warning = warning.to_i
    @critical = critical.to_i
    @css = css
    @background_color = background_color
  end

  private
  attr_reader :value, :warning, :critical, :css, :background_color

  def background_color
    if value >= critical
      "bg-danger"
    elsif value >= warning
      "bg-warning"
    else
      ""
    end
  end
end
