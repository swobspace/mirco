require 'rails_helper'

RSpec.describe "channel_statistic_groups/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'channel_statistic_groups' }
    allow(controller).to receive(:action_name) { 'new' }
    assign(:channel_statistic_group, ChannelStatisticGroup.new(
      name: "MyString"
    ))
  end

  it "renders new channel_statistic_group form" do
    render

    assert_select "form[action=?][method=?]", channel_statistic_groups_path, "post" do

      assert_select "input[name=?]", "channel_statistic_group[name]"
    end
  end
end
