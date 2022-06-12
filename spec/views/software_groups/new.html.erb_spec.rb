require 'rails_helper'

RSpec.describe "software_groups/new", type: :view do
  before(:each) do
    assign(:software_group, SoftwareGroup.new(
      name: "MyString",
      description: "MyString"
    ))
  end

  it "renders new software_group form" do
    render

    assert_select "form[action=?][method=?]", software_groups_path, "post" do

      assert_select "input[name=?]", "software_group[name]"

      assert_select "input[name=?]", "software_group[description]"
    end
  end
end
