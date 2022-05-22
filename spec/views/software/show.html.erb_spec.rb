require 'rails_helper'

RSpec.describe "software/show", type: :view do
  before(:each) do
    @software = assign(:software, Software.create!(
      location: nil,
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
  end
end
