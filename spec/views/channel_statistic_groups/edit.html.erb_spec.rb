require 'rails_helper'

RSpec.describe "channel_statistic_groups/edit", type: :view do
  let(:channel_statistic_group) {
    ChannelStatisticGroup.create!(
      name: "MyString"
    )
  }

  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'channel_statistic_groups' }
    allow(controller).to receive(:action_name) { 'edit' }
    assign(:channel_statistic_group, channel_statistic_group)
  end

  it "renders the edit channel_statistic_group form" do
    render

    assert_select "form[action=?][method=?]", channel_statistic_group_path(channel_statistic_group), "post" do

      assert_select "input[name=?]", "channel_statistic_group[name]"
    end
  end
end
