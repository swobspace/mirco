require 'rails_helper'

RSpec.describe "hosts/new", type: :view do
  before(:each) do
    assign(:host, Host.new(
      location: nil,
      software_group: nil,
      name: "MyString",
      ipaddress: "",
      description: nil
    ))
  end

  it "renders new host form" do
    render

    assert_select "form[action=?][method=?]", hosts_path, "post" do

      assert_select "input[name=?]", "host[location_id]"

      assert_select "input[name=?]", "host[software_group_id]"

      assert_select "input[name=?]", "host[name]"

      assert_select "input[name=?]", "host[ipaddress]"

      assert_select "input[name=?]", "host[description]"
    end
  end
end
