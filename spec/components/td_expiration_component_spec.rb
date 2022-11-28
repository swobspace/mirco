# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TdExpirationComponent, type: :component do
  it 'renders no background if current' do
    expect(
      render_inline(
        TdExpirationComponent.new(
          tstamp: Time.now,
          expiration_time: 5.minutes
        )
      ).to_html
    ).to include(
      <<~EOT_1
        <td class=" text-center">
          #{Time.now.to_fs(:local)}
        </td>
      EOT_1
    )
  end

  it 'renders warning background if expired' do
    expect(
      render_inline(
        TdExpirationComponent.new(
          tstamp: 1.hour.before(Time.current),
          expiration_time: 5.minutes
        )
      ).to_html
    ).to include(
      <<~EOT_2
        <td class="bg-warning text-center">
          #{1.hour.before(Time.current).localtime.to_fs(:local)}
        </td>
      EOT_2
    )
  end
end
