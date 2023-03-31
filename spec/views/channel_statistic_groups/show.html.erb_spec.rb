require 'rails_helper'

RSpec.describe "channel_statistic_groups/show", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'channel_statistic_groups' }
    allow(controller).to receive(:action_name) { 'show' }
    assign(:channel_statistic_group, ChannelStatisticGroup.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
