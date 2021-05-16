require 'rails_helper'

RSpec.describe "servers/index", type: :view do
  before(:each) do
    assign(:servers, [
      Server.create!(
        name: "Name",
        uid: "Uid",
        location: "Location",
        description: "Description",
        text: "Text",
        api_url: "Api Url",
        api_user: "Api User",
        api_password_ciphertext: "MyText",
        api_user_has_fulll_access: false,
        properties: ""
      ),
      Server.create!(
        name: "Name",
        uid: "Uid",
        location: "Location",
        description: "Description",
        text: "Text",
        api_url: "Api Url",
        api_user: "Api User",
        api_password_ciphertext: "MyText",
        api_user_has_fulll_access: false,
        properties: ""
      )
    ])
  end

  it "renders a list of servers" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Uid".to_s, count: 2
    assert_select "tr>td", text: "Location".to_s, count: 2
    assert_select "tr>td", text: "Description".to_s, count: 2
    assert_select "tr>td", text: "Text".to_s, count: 2
    assert_select "tr>td", text: "Api Url".to_s, count: 2
    assert_select "tr>td", text: "Api User".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
  end
end
