require 'rails_helper'

RSpec.describe "servers/show", type: :view do
  before(:each) do
    @server = assign(:server, Server.create!(
      name: "Name",
      uid: "Uid",
      location: "Location",
      description: "MyText",
      api_url: "Api Url",
      api_user: "Api User",
      api_password: "MyText",
      api_user_has_full_access: false,
      properties: ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Uid/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Api Url/)
    expect(rendered).to match(/Api User/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
