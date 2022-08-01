require 'rails_helper'

RSpec.describe "software_interfaces/index", type: :view do
  let(:location) { FactoryBot.create(:location, lid: "LLX", name: "Location X") }
  let(:software) { FactoryBot.create(:software, name: 'MySoft', location: location) }
  let(:host) { FactoryBot.create(:host, location_id: location.id, name: 'Quorak', ipaddress: '2.3.4.5') }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'software_interface' }
    allow(controller).to receive(:action_name) { 'index' }

    assign(:software_interfaces, [
      SoftwareInterface.create!(
        software: software,
        name: "IF Anywhere",
        host: host,
        description: 'some text'
      ),
      SoftwareInterface.create!(
        software: software,
        name: "IF Anywhere",
        host: host,
        description: 'some text'
      )
    ])
  end

  it "renders a list of software_interfaces" do
    render
    # cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    cell_selector = 'tr>td'
    assert_select cell_selector, text: Regexp.new("LLX".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("MySoft".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("IF Anywhere".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Quorak".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("2.3.4.5".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("some text".to_s), count: 2
  end
end
