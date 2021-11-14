require 'rails_helper'

RSpec.describe "alerts/show", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { "alerts" }
    allow(controller).to receive(:action_name) { "show" }
    server = FactoryBot.create(:server, name: "xyzmirth")
    channel = FactoryBot.create(:channel, server: server, name: "other_channel")

    @alert = assign(:alert, Alert.create!(
      server_id: server.id,
      channel_id: channel.id,
      type: "alert",
      message: "MyText",
      created_at: 1.hour.before(Time.now)
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/xyzmirth/)
    expect(rendered).to match(/other_channel/)
    expect(rendered).to match(/alert/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/#{1.hour.before(Time.now).to_formatted_s(:db)}/)
  end
end
