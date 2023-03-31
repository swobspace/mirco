require 'rails_helper'

RSpec.describe "channel_statistics_groups/new", type: :view do
  before(:each) do
    assign(:channel_statistics_group, ChannelStatisticsGroup.new(
      name: "MyString"
    ))
  end

  it "renders new channel_statistics_group form" do
    render

    assert_select "form[action=?][method=?]", channel_statistics_groups_path, "post" do

      assert_select "input[name=?]", "channel_statistics_group[name]"
    end
  end
end
