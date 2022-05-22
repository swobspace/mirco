require 'rails_helper'

RSpec.describe "software/new", type: :view do
  before(:each) do
    assign(:software, Software.new(
      location: nil,
      name: "MyString"
    ))
  end

  it "renders new software form" do
    render

    assert_select "form[action=?][method=?]", software_index_path, "post" do

      assert_select "input[name=?]", "software[location_id]"

      assert_select "input[name=?]", "software[name]"
    end
  end
end
