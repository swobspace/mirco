require 'rails_helper'

RSpec.describe "locations/index", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'locations' }
    allow(controller).to receive(:action_name) { 'index' }

    assign(:locations, [
      Location.create!(
        lid: "Lid1",
        name: "Name"
      ),
      Location.create!(
        lid: "Lid2",
        name: "Name"
      )
    ])
  end

  it "renders a list of locations" do
    render
    assert_select "tr>td", text: "Lid1".to_s, count: 1
    assert_select "tr>td", text: "Lid2".to_s, count: 1
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
