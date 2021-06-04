require 'rails_helper'

RSpec.describe "channel_statistics/edit", type: :view do
  before(:each) do
    @channel_statistic = assign(:channel_statistic, ChannelStatistic.create!(
      server: nil,
      channel: "",
      server_uid: "MyString",
      channel_uid: "MyString",
      received: 1,
      sent: 1,
      error: 1,
      filtered: 1,
      queued: 1
    ))
  end

  it "renders the edit channel_statistic form" do
    render

    assert_select "form[action=?][method=?]", channel_statistic_path(@channel_statistic), "post" do

      assert_select "input[name=?]", "channel_statistic[server_id]"

      assert_select "input[name=?]", "channel_statistic[channel]"

      assert_select "input[name=?]", "channel_statistic[server_uid]"

      assert_select "input[name=?]", "channel_statistic[channel_uid]"

      assert_select "input[name=?]", "channel_statistic[received]"

      assert_select "input[name=?]", "channel_statistic[sent]"

      assert_select "input[name=?]", "channel_statistic[error]"

      assert_select "input[name=?]", "channel_statistic[filtered]"

      assert_select "input[name=?]", "channel_statistic[queued]"
    end
  end
end
