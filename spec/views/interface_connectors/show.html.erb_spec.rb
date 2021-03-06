require 'rails_helper'

RSpec.describe "interface_connectors/show", type: :view do
  let(:location) { FactoryBot.create(:location, lid: "LLX", name: "Location X") }
  let(:software) { FactoryBot.create(:software, name: 'MySoft') }
  let(:host) { FactoryBot.create(:host, location: location) }
  let(:software_interface) do 
    FactoryBot.create(:software_interface, 
      host: host,
      name: 'IM4HC', 
      software: software
    )
  end

  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'interface_connectors' }
    allow(controller).to receive(:action_name) { 'show' }

    @interface_connector = assign(:interface_connector, InterfaceConnector.create!(
      software_interface_id: software_interface.id,
      name: 'BAR out',
      type: "TxConnector",
      url: "Url",
      description: 'some text'
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/LLX/)
    expect(rendered).to match(/MySoft/)
    expect(rendered).to match(/IM4HC/)
    expect(rendered).to match(/BAR out/)
    expect(rendered).to match(/TxConnector/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(/some text/)
  end
end
