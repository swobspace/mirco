require 'rails_helper'

RSpec.describe "escalation_levels/new", type: :view do
  before(:each) do
    assign(:escalation_level, EscalationLevel.new(
      escalatable: nil,
      attrib: "MyString",
      min_critical: 1,
      min_warning: 1,
      max_warning: 1,
      max_critical: 1
    ))
  end

  it "renders new escalation_level form" do
    render

    assert_select "form[action=?][method=?]", escalation_levels_path, "post" do

      assert_select "input[name=?]", "escalation_level[escalatable_id]"

      assert_select "input[name=?]", "escalation_level[attrib]"

      assert_select "input[name=?]", "escalation_level[min_critical]"

      assert_select "input[name=?]", "escalation_level[min_warning]"

      assert_select "input[name=?]", "escalation_level[max_warning]"

      assert_select "input[name=?]", "escalation_level[max_critical]"
    end
  end
end
