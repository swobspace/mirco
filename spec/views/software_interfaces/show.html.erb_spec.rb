require 'rails_helper'

RSpec.describe "software_interfaces/show", type: :view do
  let(:software) { FactoryBot.create(:software, name: 'MySoft') }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'software_interface' }
    allow(controller).to receive(:action_name) { 'new' }

    @software_interface = assign(:software_interface, SoftwareInterface.create!(
      software: software,
      name: "Name",
      hostname: "Hostname",
      ipaddress: "1.2.3.4",
      description: 'some text'
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/MySoft/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Hostname/)
    expect(rendered).to match(/1.2.3.4/)
    expect(rendered).to match(/some text/)
  end
end
