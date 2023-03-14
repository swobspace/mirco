require 'rails_helper'

RSpec.describe "escalation_times/show", type: :view do
  before(:each) do
    assign(:escalation_time, EscalationTime.create!(
      escalation_level: nil,
      weekdays: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
  end
end
