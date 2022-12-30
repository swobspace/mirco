require 'rails_helper'

RSpec.describe "escalation_levels/show", type: :view do
  let(:cs) { FactoryBot.create(:channel_statistic, name: 'Some Statistics') }
  let(:escalation_level) do
    FactoryBot.create(:escalation_level, 
      escalatable_id: cs.id,
      escalatable_type: 'ChannelStatistic',
      attrib: 'last_message_received_at',
      min_critical: -30,
      min_warning: -15,
      max_warning: 20,
      max_critical: 50)
  end

  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'escalation_levels' }
    allow(controller).to receive(:action_name) { 'show' }
    assign(:escalation_level, escalation_level)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Some Statistics/)
    expect(rendered).to match(/last_message_received_at/)
    expect(rendered).to match(/-30/)
    expect(rendered).to match(/-15/)
    expect(rendered).to match(/20/)
    expect(rendered).to match(/50/)
  end
end
