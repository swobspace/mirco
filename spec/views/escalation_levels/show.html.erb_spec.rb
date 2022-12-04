require 'rails_helper'

RSpec.describe "escalation_levels/show", type: :view do
  before(:each) do
    assign(:escalation_level, EscalationLevel.create!(
      escalatable: nil,
      attrib: "Attrib",
      min_critical: 2,
      min_warning: 3,
      max_warning: 4,
      max_critical: 5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Attrib/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
  end
end
