require 'rails_helper'

RSpec.describe "channel_statistics_groups/edit", type: :view do
  let(:channel_statistics_group) {
    ChannelStatisticsGroup.create!(
      name: "MyString"
    )
  }

  before(:each) do
    assign(:channel_statistics_group, channel_statistics_group)
  end

  it "renders the edit channel_statistics_group form" do
    render

    assert_select "form[action=?][method=?]", channel_statistics_group_path(channel_statistics_group), "post" do

      assert_select "input[name=?]", "channel_statistics_group[name]"
    end
  end
end
