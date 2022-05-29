require 'rails_helper'

RSpec.describe "interface_connectors/show", type: :view do
  before(:each) do
    @interface_connector = assign(:interface_connector, InterfaceConnector.create!(
      software_interface: nil,
      type: "Type",
      url: "Url",
      description: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/Url/)
    expect(rendered).to match(//)
  end
end
