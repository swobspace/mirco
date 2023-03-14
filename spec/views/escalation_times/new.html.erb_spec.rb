require 'rails_helper'

RSpec.describe "escalation_times/new", type: :view do
  before(:each) do
    assign(:escalation_time, EscalationTime.new(
      escalation_level: nil,
      weekdays: 1
    ))
  end

  it "renders new escalation_time form" do
    render

    assert_select "form[action=?][method=?]", escalation_times_path, "post" do

      assert_select "input[name=?]", "escalation_time[escalation_level_id]"

      assert_select "input[name=?]", "escalation_time[weekdays]"
    end
  end
end
