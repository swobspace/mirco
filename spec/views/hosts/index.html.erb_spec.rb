require 'rails_helper'

RSpec.describe "hosts/index", type: :view do
  let(:location) { FactoryBot.create(:location, lid: "LXC") }
  let(:software_group) { FactoryBot.create(:software_group, name: "Gamma Y") }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'hosts' }
    allow(controller).to receive(:action_name) { 'index' }

    assign(:hosts, [
      Host.create!(
        location: location,
        software_group: software_group,
        name: "Name",
        ipaddress: "1.2.3.4",
        description: "blafasel"
      ),
      Host.create!(
        location: location,
        software_group: software_group,
        name: "Name",
        ipaddress: "3.4.5.6",
        description: "blafasel"
      )
    ])
  end

  it "renders a list of hosts" do
    render
    # cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("LXC".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Gamma Y".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("1.2.3.4".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("3.4.5.6".to_s), count: 1
    assert_select cell_selector, text: Regexp.new("blafasel".to_s), count: 2
  end
end
