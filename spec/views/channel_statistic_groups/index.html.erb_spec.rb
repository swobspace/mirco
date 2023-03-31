require 'rails_helper'

RSpec.describe "channel_statistic_groups/index", type: :view do
  before(:each) do
    assign(:channel_statistic_groups, [
      ChannelStatisticGroup.create!(
        name: "Name"
      ),
      ChannelStatisticGroup.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of channel_statistic_groups" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
  end
end
