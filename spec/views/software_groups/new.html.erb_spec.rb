require 'rails_helper'

RSpec.describe "software_groups/new", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'software_group' }
    allow(controller).to receive(:action_name) { 'edit' }

    @software_group = assign(:software_group, FactoryBot.build(:software_group))
  end

  it "renders new software_group form" do
    render

    assert_select "form[action=?][method=?]", software_groups_path, "post" do

      assert_select "input[name=?]", "software_group[name]"

      assert_select "input[name=?]", "software_group[description]"
    end
  end
end
