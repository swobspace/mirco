require "rails_helper"

RSpec.describe TdExpirationComponent, type: :component do
  it "renders no background if current" do
    expect(
      render_inline(
        TdExpirationComponent.new(
          tstamp: Time.now, 
          expiration_time: 5.minutes
        )
      ).to_html
    ).to include(
<<-EOT
<td class="">
  #{Time.now.localtime.to_formatted_s(:db)}
</td>
EOT
    )
  end

  it "renders warning background if expired" do
    expect(
      render_inline(
        TdExpirationComponent.new(
          tstamp: 1.hour.before(Time.now), 
          expiration_time: 5.minutes
        )
      ).to_html
    ).to include(
<<-EOT
<td class="bg-warning">
  #{1.hour.before(Time.now).localtime.to_formatted_s(:db)}
</td>
EOT
    )
  end

end
