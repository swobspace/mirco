require 'rails_helper'

RSpec.describe "software_interfaces/index", type: :view do
  let(:software) { FactoryBot.create(:software, name: 'MySoft') }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'software_interface' }
    allow(controller).to receive(:action_name) { 'index' }

    assign(:software_interfaces, [
      SoftwareInterface.create!(
        software: software,
        name: "Name",
        hostname: "Hostname",
        ipaddress: "1.2.3.4",
        description: 'some text'
      ),
      SoftwareInterface.create!(
        software: software,
        name: "Name",
        hostname: "Hostname",
        ipaddress: "1.2.3.4",
        description: 'some text'
      )
    ])
  end

  it "renders a list of software_interfaces" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("MySoft".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Hostname".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("1.2.3.4".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("some text".to_s), count: 2
  end
end
