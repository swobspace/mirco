require 'rails_helper'

RSpec.describe "software_groups/index", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'software_group' }
    allow(controller).to receive(:action_name) { 'index' }

    assign(:software_groups, [
      SoftwareGroup.create!(
        name: "Name1704",
        description: "Description"
      ),
      SoftwareGroup.create!(
        name: "Name0815",
        description: "Description"
      )
    ])
  end

  it "renders a list of software_groups" do
    render
    # cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name1704".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Name0815".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("Description".to_s), count: 2
  end
end
