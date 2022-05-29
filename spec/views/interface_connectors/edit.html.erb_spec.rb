require 'rails_helper'

RSpec.describe "interface_connectors/edit", type: :view do
  before(:each) do
    @interface_connector = assign(:interface_connector, InterfaceConnector.create!(
      software_interface: nil,
      type: "",
      url: "MyString",
      description: nil
    ))
  end

  it "renders the edit interface_connector form" do
    render

    assert_select "form[action=?][method=?]", interface_connector_path(@interface_connector), "post" do

      assert_select "input[name=?]", "interface_connector[software_interface_id]"

      assert_select "input[name=?]", "interface_connector[type]"

      assert_select "input[name=?]", "interface_connector[url]"

      assert_select "input[name=?]", "interface_connector[description]"
    end
  end
end
