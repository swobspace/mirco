require 'rails_helper'

RSpec.describe "channel_statistic_groups/new", type: :view do
  before(:each) do
    assign(:channel_statistic_group, ChannelStatisticGroup.new(
      name: "MyString"
    ))
  end

  it "renders new channel_statistic_group form" do
    render

    assert_select "form[action=?][method=?]", channel_statistic_groups_path, "post" do

      assert_select "input[name=?]", "channel_statistic_group[name]"
    end
  end
end
