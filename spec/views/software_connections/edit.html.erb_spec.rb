require 'rails_helper'

RSpec.describe "software_connections/edit", type: :view do
  before(:each) do
    @software_connection = assign(:software_connection, SoftwareConnection.create!(
      source_connector: nil,
      source_url: "MyString",
      destination_connector: nil,
      destination_url: "MyString",
      ignore: false,
      ignore_reason: "MyString",
      description: nil
    ))
  end

  it "renders the edit software_connection form" do
    render

    assert_select "form[action=?][method=?]", software_connection_path(@software_connection), "post" do

      assert_select "input[name=?]", "software_connection[source_connector_id]"

      assert_select "input[name=?]", "software_connection[source_url]"

      assert_select "input[name=?]", "software_connection[destination_connector_id]"

      assert_select "input[name=?]", "software_connection[destination_url]"

      assert_select "input[name=?]", "software_connection[ignore]"

      assert_select "input[name=?]", "software_connection[ignore_reason]"

      assert_select "input[name=?]", "software_connection[description]"
    end
  end
end
