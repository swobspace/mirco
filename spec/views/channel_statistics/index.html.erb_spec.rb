require 'rails_helper'

RSpec.describe "channel_statistics/index", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "channel_statistics" }
    allow(controller).to receive(:action_name) { "index" }
    @server = FactoryBot.create(:server, :with_uid, name: "xyzmirth")
    channel1 = FactoryBot.create(:channel, server: @server)
    channel2 = FactoryBot.create(:channel, server: @server)
    assign(:channel_statistics, [
      ChannelStatistic.create!(
        server: @server,
        channel: channel1,
        server_uid: @server.uid,
        channel_uid: channel1.uid,
        received: 2,
        sent: 3,
        error: 4,
        filtered: 5,
        queued: 6
      ),
      ChannelStatistic.create!(
        server: @server,
        channel: channel2,
        server_uid: @server.uid,
        channel_uid: channel2.uid,
        received: 2,
        sent: 3,
        error: 4,
        filtered: 5,
        queued: 6
      )
    ])
    allow(channel1).to receive(:name).and_return("Channel1")
    allow(channel2).to receive(:name).and_return("Channel2")
  end

  it "renders a list of channel_statistics" do
    render
    assert_select "tr>td", text: @server.to_s, count: 0
    assert_select "tr>td", text: "Channel1", count: 1
    assert_select "tr>td", text: "Channel2", count: 1
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
    assert_select "tr>td", text: 5.to_s, count: 2
    assert_select "tr>td", text: 6.to_s, count: 2
  end
end
