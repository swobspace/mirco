require 'rails_helper'

RSpec.describe "hosts/edit", type: :view do
  before(:each) do
    @host = assign(:host, Host.create!(
      location: nil,
      software_group: nil,
      name: "MyString",
      ipaddress: "",
      description: nil
    ))
  end

  it "renders the edit host form" do
    render

    assert_select "form[action=?][method=?]", host_path(@host), "post" do

      assert_select "input[name=?]", "host[location_id]"

      assert_select "input[name=?]", "host[software_group_id]"

      assert_select "input[name=?]", "host[name]"

      assert_select "input[name=?]", "host[ipaddress]"

      assert_select "input[name=?]", "host[description]"
    end
  end
end
