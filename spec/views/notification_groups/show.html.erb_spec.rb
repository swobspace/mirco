require 'rails_helper'

RSpec.describe "notification_groups/show", type: :view do
  before(:each) do
    assign(:notification_group, NotificationGroup.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
