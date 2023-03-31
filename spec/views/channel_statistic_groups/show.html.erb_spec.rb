require 'rails_helper'

RSpec.describe "channel_statistic_groups/show", type: :view do
  before(:each) do
    assign(:channel_statistic_group, ChannelStatisticGroup.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
