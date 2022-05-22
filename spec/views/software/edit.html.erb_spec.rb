require 'rails_helper'

RSpec.describe "software/edit", type: :view do
  before(:each) do
    @software = assign(:software, Software.create!(
      location: nil,
      name: "MyString"
    ))
  end

  it "renders the edit software form" do
    render

    assert_select "form[action=?][method=?]", software_path(@software), "post" do

      assert_select "input[name=?]", "software[location_id]"

      assert_select "input[name=?]", "software[name]"
    end
  end
end
