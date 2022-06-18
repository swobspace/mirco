require 'rails_helper'

RSpec.describe "software/index", type: :view do
  let(:location) { FactoryBot.create(:location, lid: "L1") }
  let(:software_group) { FactoryBot.create(:software_group, name: "Radiology") }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'software' }
    allow(controller).to receive(:action_name) { 'index' }

    assign(:software, [
      Software.create!(
        location: location,
        software_group: software_group,
        name: "Name",
        vendor: "ACME small"
      ),
      Software.create!(
        location: location,
        software_group: software_group,
        name: "Name",
        vendor: "ACME small"
      )
    ])
  end

  it "renders a list of software" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("L1".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("ACME small".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Radiology".to_s), count: 2
  end
end
