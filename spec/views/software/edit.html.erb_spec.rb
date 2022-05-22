require 'rails_helper'

RSpec.describe "software/edit", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'software' }
    allow(controller).to receive(:action_name) { 'edit' }

    @software = assign(:software, FactoryBot.create(:software))
  end

  it "renders the edit software form" do
    render

    assert_select "form[action=?][method=?]", software_path(@software), "post" do

      assert_select "select[name=?]", "software[location_id]"

      assert_select "input[name=?]", "software[name]"
    end
  end
end
