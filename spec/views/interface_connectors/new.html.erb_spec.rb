require 'rails_helper'

RSpec.describe "interface_connectors/new", type: :view do
  before(:each) do
    assign(:interface_connector, InterfaceConnector.new(
      software_interface: nil,
      type: "",
      url: "MyString",
      description: nil
    ))
  end

  it "renders new interface_connector form" do
    render

    assert_select "form[action=?][method=?]", interface_connectors_path, "post" do

      assert_select "input[name=?]", "interface_connector[software_interface_id]"

      assert_select "input[name=?]", "interface_connector[type]"

      assert_select "input[name=?]", "interface_connector[url]"

      assert_select "input[name=?]", "interface_connector[description]"
    end
  end
end
