require 'rails_helper'

RSpec.describe "escalation_times/index", type: :view do
  before(:each) do
    assign(:escalation_times, [
      EscalationTime.create!(
        escalation_level: nil,
        weekdays: 2
      ),
      EscalationTime.create!(
        escalation_level: nil,
        weekdays: 2
      )
    ])
  end

  it "renders a list of escalation_times" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
