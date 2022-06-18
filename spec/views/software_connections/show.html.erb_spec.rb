require 'rails_helper'

RSpec.describe "software_connections/show", type: :view do
  let(:server) { FactoryBot.create(:server, name: 'XYZMIRTH') }
  let(:location) { FactoryBot.create(:location, lid: 'LLY') }
  let(:conn1) { FactoryBot.create(:interface_connector) }
  let(:conn2) { FactoryBot.create(:interface_connector) }
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'software_connection' }
    allow(controller).to receive(:action_name) { 'index' }
    allow(conn1).to receive(:to_s).and_return("SWIF1")
    allow(conn2).to receive(:to_s).and_return("SWIF2")

    @software_connection = assign(:software_connection, SoftwareConnection.create!(
      server: server,
      location: location,
      source_connector: conn1,
      source_url: "Source Url",
      destination_connector: conn2,
      destination_url: "Destination Url",
      ignore: false,
      ignore_reason: "Ignore Reason",
      description: "Some TEXT"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/LLY/)
    expect(rendered).to match(/XYZMIRTH/)
    expect(rendered).to match(/#{conn1.sw_name}/)
    expect(rendered).to match(/#{conn1.if_name}/)
    expect(rendered).to match(/SWIF1/)
    expect(rendered).to match(/Source Url/)
    expect(rendered).to match(/#{conn2.sw_name}/)
    expect(rendered).to match(/#{conn2.if_name}/)
    expect(rendered).to match(/SWIF2/)
    expect(rendered).to match(/Destination Url/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Ignore Reason/)
    expect(rendered).to match(/Some TEXT/)
  end
end
