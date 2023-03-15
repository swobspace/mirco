require 'rails_helper'

RSpec.describe "notification_groups/show", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'notification_group' }
    allow(controller).to receive(:action_name) { 'show' }

    assign(:notification_group, FactoryBot.create(:notification_group, name: 'NewName'))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/NewName/)
  end
end
