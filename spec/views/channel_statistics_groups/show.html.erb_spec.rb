require 'rails_helper'

RSpec.describe "channel_statistics_groups/show", type: :view do
  before(:each) do
    assign(:channel_statistics_group, ChannelStatisticsGroup.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
