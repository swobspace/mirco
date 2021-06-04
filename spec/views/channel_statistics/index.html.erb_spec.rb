require 'rails_helper'

RSpec.describe "channel_statistics/index", type: :view do
  before(:each) do
    assign(:channel_statistics, [
      ChannelStatistic.create!(
        server: nil,
        channel: "",
        server_uid: "Server Uid",
        channel_uid: "Channel Uid",
        received: 2,
        sent: 3,
        error: 4,
        filtered: 5,
        queued: 6
      ),
      ChannelStatistic.create!(
        server: nil,
        channel: "",
        server_uid: "Server Uid",
        channel_uid: "Channel Uid",
        received: 2,
        sent: 3,
        error: 4,
        filtered: 5,
        queued: 6
      )
    ])
  end

  it "renders a list of channel_statistics" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
    assert_select "tr>td", text: "Server Uid".to_s, count: 2
    assert_select "tr>td", text: "Channel Uid".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
    assert_select "tr>td", text: 5.to_s, count: 2
    assert_select "tr>td", text: 6.to_s, count: 2
  end
end
