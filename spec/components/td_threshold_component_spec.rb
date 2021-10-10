require "rails_helper"

RSpec.describe TdThresholdComponent, type: :component do
  it "renders no background if low value" do
    expect(
      render_inline(
        TdThresholdComponent.new(value: 2, warning: 5, critical: 10)
      ).to_html
    ).to include(
<<-EOT
<td class="">
  2
</td>
EOT
    )
  end

  it "renders warning if value > :warning" do
    expect(
      render_inline(
        TdThresholdComponent.new(value: 7, warning: 5, critical: 10)
      ).to_html
    ).to include(
<<-EOT
<td class="bg-warning">
  7
</td>
EOT
    )
  end

  it "renders critical if value > :critical" do
    expect(
      render_inline(
        TdThresholdComponent.new(value: 99, warning: 5, critical: 10)
      ).to_html
    ).to include(
<<-EOT
<td class="bg-danger">
  99
</td>
EOT
    )
  end

  it "renders alert if value > :critical and alert-condition = true" do
    expect(
      render_inline(
        TdThresholdComponent.new(value: 99, warning: 5, alert: true, critical: 10)
      ).to_html
    ).to include(
<<-EOT
<td class="bg-alert">
  99
</td>
EOT
    )
  end

  it "renders additional css class" do
    expect(
      render_inline(
        TdThresholdComponent.new(value: 99, warning: 5, critical: 10, css: "text-end")
      ).to_html
    ).to include(
<<-EOT
<td class="bg-danger text-end">
  99
</td>
EOT
    )
  end

end
