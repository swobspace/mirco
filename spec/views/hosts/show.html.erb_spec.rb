require 'rails_helper'

RSpec.describe "hosts/show", type: :view do
  before(:each) do
    @host = assign(:host, Host.create!(
      location: nil,
      software_group: nil,
      name: "Name",
      ipaddress: "",
      description: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
