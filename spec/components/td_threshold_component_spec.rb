# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TdThresholdComponent, type: :component do
  it 'renders no background if low value' do
    expect(
      render_inline(
        TdThresholdComponent.new(value: 2, warning: 5, critical: 10)
      ).to_html
    ).to include(
      <<~EOT_1
        <td class="">
          2
        </td>
      EOT_1
    )
  end

  it 'renders warning if value > :warning' do
    expect(
      render_inline(
        TdThresholdComponent.new(value: 7, warning: 5, critical: 10)
      ).to_html
    ).to include(
      <<~EOT_2
        <td class="bg-warning">
          7
        </td>
      EOT_2
    )
  end

  it 'renders critical if value > :critical' do
    expect(
      render_inline(
        TdThresholdComponent.new(value: 99, warning: 5, critical: 10)
      ).to_html
    ).to include(
      <<~EOT_3
        <td class="bg-danger">
          99
        </td>
      EOT_3
    )
  end

  it 'renders alert if value > :critical and alert-condition = true' do
    expect(
      render_inline(
        TdThresholdComponent.new(value: 99, warning: 5, alert: true, critical: 10)
      ).to_html
    ).to include(
      <<~EOT_4
        <td class="bg-alert">
          99
        </td>
      EOT_4
    )
  end

  it 'renders additional css class' do
    expect(
      render_inline(
        TdThresholdComponent.new(value: 99, warning: 5, critical: 10, css: 'text-end')
      ).to_html
    ).to include(
      <<~EOT_5
        <td class="bg-danger text-end">
          99
        </td>
      EOT_5
    )
  end
end
