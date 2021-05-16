require 'rails_helper'

RSpec.describe "servers/new", type: :view do
  before(:each) do
    assign(:server, Server.new(
      name: "MyString",
      uid: "MyString",
      location: "MyString",
      description: "MyString",
      text: "MyString",
      api_url: "MyString",
      api_user: "MyString",
      api_password_ciphertext: "MyText",
      api_user_has_fulll_access: false,
      properties: ""
    ))
  end

  it "renders new server form" do
    render

    assert_select "form[action=?][method=?]", servers_path, "post" do

      assert_select "input[name=?]", "server[name]"

      assert_select "input[name=?]", "server[uid]"

      assert_select "input[name=?]", "server[location]"

      assert_select "input[name=?]", "server[description]"

      assert_select "input[name=?]", "server[text]"

      assert_select "input[name=?]", "server[api_url]"

      assert_select "input[name=?]", "server[api_user]"

      assert_select "textarea[name=?]", "server[api_password_ciphertext]"

      assert_select "input[name=?]", "server[api_user_has_fulll_access]"

      assert_select "input[name=?]", "server[properties]"
    end
  end
end
