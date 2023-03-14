require 'rails_helper'

RSpec.describe "escalation_times/edit", type: :view do
  let(:escalation_time) {
    EscalationTime.create!(
      escalation_level: nil,
      weekdays: 1
    )
  }

  before(:each) do
    assign(:escalation_time, escalation_time)
  end

  it "renders the edit escalation_time form" do
    render

    assert_select "form[action=?][method=?]", escalation_time_path(escalation_time), "post" do

      assert_select "input[name=?]", "escalation_time[escalation_level_id]"

      assert_select "input[name=?]", "escalation_time[weekdays]"
    end
  end
end
