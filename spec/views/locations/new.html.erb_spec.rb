require 'rails_helper'

RSpec.describe "locations/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'locations' }
    allow(controller).to receive(:action_name) { 'new' }

    assign(:location, Location.new(
      lid: "MyString",
      name: "MyString"
    ))
  end

  it "renders new location form" do
    render

    assert_select "form[action=?][method=?]", locations_path, "post" do

      assert_select "input[name=?]", "location[lid]"

      assert_select "input[name=?]", "location[name]"
    end
  end
end
