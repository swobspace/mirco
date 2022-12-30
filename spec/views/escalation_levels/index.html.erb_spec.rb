require 'rails_helper'

RSpec.describe "escalation_levels/index", type: :view do
  let(:cs) { FactoryBot.create(:channel_statistic, name: 'Some Statistics') }
  let(:escalation_levels) do
    [ 
      FactoryBot.create(:escalation_level,
        escalatable_id: cs.id,
        escalatable_type: 'ChannelStatistic',
        attrib: 'last_message_received_at',
        min_critical: -30,
        min_warning: -15,
        max_warning: 20,
        max_critical: 51),
      FactoryBot.create(:escalation_level,
        escalatable_id: 0,
        escalatable_type: 'ChannelStatistic',
        attrib: 'last_message_received_at',
        min_critical: -30,
        min_warning: -15,
        max_warning: 20,
        max_critical: 52)
    ]
  end

  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'escalation_levels' }
    allow(controller).to receive(:action_name) { 'index' }
    assign(:escalation_levels, escalation_levels)
  end

  it "renders a list of escalation_levels" do
    render
    # cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Some Statistics".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("last_message_received_at".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(-30.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(-15.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(20.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(51.to_s), count: 1
    assert_select cell_selector, text: Regexp.new(52.to_s), count: 1
  end
end
