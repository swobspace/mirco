require 'rails_helper'

RSpec.describe "software/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'software' }
    allow(controller).to receive(:action_name) { 'index' }

    assign(:software, FactoryBot.build(:software))
  end

  it "renders new software form" do
    render

    assert_select "form[action=?][method=?]", software_index_path, "post" do

      assert_select "select[name=?]", "software[location_id]"
      assert_select "input[name=?]", "software[name]"
      assert_select "input[name=?]", "software[vendor]"
      assert_select "select[name=?]", "software[software_group_id]"
    end
  end
end
