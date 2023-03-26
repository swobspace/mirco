require 'rails_helper'

RSpec.describe "notification_groups/new", type: :view do
  let(:notification_group) { FactoryBot.build(:notification_group) }

  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'notification_group' }
    allow(controller).to receive(:action_name) { 'new' }
    assign(:notification_group, notification_group)
  end

  it "renders new notification_group form" do
    render

    assert_select "form[action=?][method=?]", notification_groups_path, "post" do

      assert_select "input[name=?]", "notification_group[name]"
    end
  end
end
