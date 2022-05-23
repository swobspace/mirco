require 'rails_helper'

RSpec.describe "software_interfaces/edit", type: :view do
  before(:each) do
    @software_interface = assign(:software_interface, SoftwareInterface.create!(
      software: nil,
      name: "MyString",
      hostname: "MyString",
      ipaddress: "",
      description: nil
    ))
  end

  it "renders the edit software_interface form" do
    render

    assert_select "form[action=?][method=?]", software_interface_path(@software_interface), "post" do

      assert_select "input[name=?]", "software_interface[software_id]"

      assert_select "input[name=?]", "software_interface[name]"

      assert_select "input[name=?]", "software_interface[hostname]"

      assert_select "input[name=?]", "software_interface[ipaddress]"

      assert_select "input[name=?]", "software_interface[description]"
    end
  end
end
