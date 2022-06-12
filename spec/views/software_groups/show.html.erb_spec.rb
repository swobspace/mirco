require 'rails_helper'

RSpec.describe "software_groups/show", type: :view do
  before(:each) do
    @software_group = assign(:software_group, SoftwareGroup.create!(
      name: "Name",
      description: "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Description/)
  end
end
