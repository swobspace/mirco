require 'rails_helper'

RSpec.describe "channel_statistic_groups/index", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'channel_statistic_groups' }
    allow(controller).to receive(:action_name) { 'index' }
    assign(:channel_statistic_groups, [
      ChannelStatisticGroup.create!(
        name: "Name1"
      ),
      ChannelStatisticGroup.create!(
        name: "Name2"
      )
    ])
  end

  it "renders a list of channel_statistic_groups" do
    render
    # cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name1".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Name1".to_s), count: 1
  end
end
