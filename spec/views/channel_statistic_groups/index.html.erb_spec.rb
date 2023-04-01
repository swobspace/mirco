require 'rails_helper'

RSpec.describe "channel_statistic_groups/index", type: :view do
  let(:cs) { FactoryBot.create(:channel_statistic, name: 'TxCWD') }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'channel_statistic_groups' }
    allow(controller).to receive(:action_name) { 'index' }
    assign(:channel_statistic_groups, [
      ChannelStatisticGroup.create!(
        name: "Name1", 
        channel_statistic_ids: [cs.id]
      ),
      ChannelStatisticGroup.create!(
        name: "Name2",
        channel_statistic_ids: [cs.id]
      )
    ])
  end

  it "renders a list of channel_statistic_groups" do
    render
    # cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name1".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Name1".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("#{cs.server.to_s} >  > TxCWD".to_s), count: 2
  end
end
