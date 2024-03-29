require 'rails_helper'

RSpec.describe "notification_groups/edit", type: :view do
  let(:notification_group) { FactoryBot.create(:notification_group) }

  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'notification_group' }
    allow(controller).to receive(:action_name) { 'edit' }
    assign(:notification_group, notification_group)
  end

  it "renders the edit notification_group form" do
    render

    assert_select "form[action=?][method=?]", notification_group_path(notification_group), "post" do

      assert_select "input[name=?]", "notification_group[name]"
    end
  end
end
