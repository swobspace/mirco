require 'rails_helper'

RSpec.describe "software_connections/show", type: :view do
  before(:each) do
    @software_connection = assign(:software_connection, SoftwareConnection.create!(
      source_connector: nil,
      source_url: "Source Url",
      destination_connector: nil,
      destination_url: "Destination Url",
      ignore: false,
      ignore_reason: "Ignore Reason",
      description: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Source Url/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Destination Url/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Ignore Reason/)
    expect(rendered).to match(//)
  end
end
