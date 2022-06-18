require 'rails_helper'

RSpec.describe "hosts/show", type: :view do
  let(:location) { FactoryBot.create(:location, lid: "LXC") }
  let(:software_group) { FactoryBot.create(:software_group, name: "Gamma Y") }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'hosts' }
    allow(controller).to receive(:action_name) { 'index' }

    @host = assign(:host, Host.create!(
      location: location,
      software_group: software_group,
      name: "Name",
      ipaddress: "2.3.4.5",
      description: "blafasel"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/LXC/)
    expect(rendered).to match(/Gamma Y/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2.3.4.5/)
    expect(rendered).to match(/blafasel/)
  end
end
