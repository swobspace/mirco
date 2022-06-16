require 'rails_helper'

RSpec.describe "software_interfaces/show", type: :view do
  let(:location) { FactoryBot.create(:location, lid: "LLX", name: "Location X") }
  let(:software) { FactoryBot.create(:software, name: 'MySoft', location: location) }
  let(:host) { FactoryBot.create(:host, location_id: location.id, name: 'Quorak', ipaddress: '2.3.4.5') }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'software_interface' }
    allow(controller).to receive(:action_name) { 'new' }

    @software_interface = assign(:software_interface, SoftwareInterface.create!(
      software: software,
      name: "Name",
      host: host,
      description: 'some text'
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/LLX: Location X/)
    expect(rendered).to match(/MySoft/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Quorak/)
    expect(rendered).to match(/2.3.4.5/)
    expect(rendered).to match(/some text/)
  end
end
