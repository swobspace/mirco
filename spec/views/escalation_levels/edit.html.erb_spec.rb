require 'rails_helper'

RSpec.describe "escalation_levels/edit", type: :view do
  let(:escalation_level) {
    EscalationLevel.create!(
      escalatable: nil,
      attrib: "MyString",
      min_critical: 1,
      min_warning: 1,
      max_warning: 1,
      max_critical: 1
    )
  }

  before(:each) do
    assign(:escalation_level, escalation_level)
  end

  it "renders the edit escalation_level form" do
    render

    assert_select "form[action=?][method=?]", escalation_level_path(escalation_level), "post" do

      assert_select "input[name=?]", "escalation_level[escalatable_id]"

      assert_select "input[name=?]", "escalation_level[attrib]"

      assert_select "input[name=?]", "escalation_level[min_critical]"

      assert_select "input[name=?]", "escalation_level[min_warning]"

      assert_select "input[name=?]", "escalation_level[max_warning]"

      assert_select "input[name=?]", "escalation_level[max_critical]"
    end
  end
end
