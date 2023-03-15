require 'rails_helper'

RSpec.describe "notification_groups/index", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'notification_group' }
    allow(controller).to receive(:action_name) { 'Index' }

    assign(:notification_groups, [
      NotificationGroup.create!(
        name: "Name1"
      ),
      NotificationGroup.create!(
        name: "Name2"
      )
    ])
  end

  it "renders a list of notification_groups" do
    render
    # cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name1".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Name2".to_s), count: 1
  end
end
