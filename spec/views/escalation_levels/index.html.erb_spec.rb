require 'rails_helper'

RSpec.describe "escalation_levels/index", type: :view do
  before(:each) do
    assign(:escalation_levels, [
      EscalationLevel.create!(
        escalatable: nil,
        attrib: "Attrib",
        min_critical: 2,
        min_warning: 3,
        max_warning: 4,
        max_critical: 5
      ),
      EscalationLevel.create!(
        escalatable: nil,
        attrib: "Attrib",
        min_critical: 2,
        min_warning: 3,
        max_warning: 4,
        max_critical: 5
      )
    ])
  end

  it "renders a list of escalation_levels" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Attrib".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(3.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(4.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(5.to_s), count: 2
  end
end
