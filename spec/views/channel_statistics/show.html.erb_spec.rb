require 'rails_helper'

RSpec.describe "channel_statistics/show", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "channel_statistics" }
    allow(controller).to receive(:action_name) { "index" }
    @server = FactoryBot.create(:server, :with_uid, name: "xyzmirth")
    @channel = FactoryBot.create(:channel, server: @server)

    @channel_statistic = assign(:channel_statistic, ChannelStatistic.create!(
      server: @server,
      channel: @channel,
      server_uid: @server.uid,
      channel_uid: @channel.uid,
      received: 2,
      sent: 3,
      error: 4,
      filtered: 5,
      queued: 6
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/#{@server}/)
    expect(rendered).to match(/#{@channel}/)
    expect(rendered).to match(/#{@server.uid}/)
    expect(rendered).to match(/#{@channel.uid}/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
  end
end
