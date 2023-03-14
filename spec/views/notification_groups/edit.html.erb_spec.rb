require 'rails_helper'

RSpec.describe "notification_groups/edit", type: :view do
  let(:notification_group) {
    NotificationGroup.create!(
      name: "MyString"
    )
  }

  before(:each) do
    assign(:notification_group, notification_group)
  end

  it "renders the edit notification_group form" do
    render

    assert_select "form[action=?][method=?]", notification_group_path(notification_group), "post" do

      assert_select "input[name=?]", "notification_group[name]"
    end
  end
end
