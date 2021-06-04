require 'rails_helper'

RSpec.describe "channel_statistics/show", type: :view do
  before(:each) do
    @channel_statistic = assign(:channel_statistic, ChannelStatistic.create!(
      server: nil,
      channel: "",
      server_uid: "Server Uid",
      channel_uid: "Channel Uid",
      received: 2,
      sent: 3,
      error: 4,
      filtered: 5,
      queued: 6
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Server Uid/)
    expect(rendered).to match(/Channel Uid/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
  end
end
