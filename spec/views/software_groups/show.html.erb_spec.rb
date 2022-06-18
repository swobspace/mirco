require 'rails_helper'

RSpec.describe "software_groups/show", type: :view do
  before(:each) do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    allow(controller).to receive(:current_ability) { @ability }
    allow(controller).to receive(:controller_name) { 'software_group' }
    allow(controller).to receive(:action_name) { 'show' }

    @software_group = assign(:software_group, SoftwareGroup.create!(
      name: "Name3337",
      description: "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name3337/)
    expect(rendered).to match(/Description/)
  end
end
