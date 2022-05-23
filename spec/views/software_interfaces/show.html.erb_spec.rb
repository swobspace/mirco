require 'rails_helper'

RSpec.describe "software_interfaces/show", type: :view do
  before(:each) do
    @software_interface = assign(:software_interface, SoftwareInterface.create!(
      software: nil,
      name: "Name",
      hostname: "Hostname",
      ipaddress: "",
      description: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Hostname/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
