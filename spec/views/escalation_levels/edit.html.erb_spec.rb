require 'rails_helper'

RSpec.describe "escalation_levels/edit", type: :view do
  let(:escalation_level) do
    FactoryBot.create(:escalation_level, attrib: 'last_message_received_at')
  end

  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'escalation_levels' }
    allow(controller).to receive(:action_name) { 'edit' }

    assign(:escalation_level, escalation_level)
  end

  it "renders the edit escalation_level form" do
    render

    assert_select "form[action=?][method=?]", escalation_level_path(escalation_level), "post" do
      assert_select "input[name=?]", "escalation_level[attrib]"
      assert_select "input[name=?]", "escalation_level[min_critical]"
      assert_select "input[name=?]", "escalation_level[min_warning]"
      assert_select "input[name=?]", "escalation_level[max_warning]"
      assert_select "input[name=?]", "escalation_level[max_critical]"
      assert_select "select[name=?]", "escalation_level[notification_group_id]"
      assert_select "input[name=?]", "escalation_level[show_on_dashboard]"
    end
  end
end
