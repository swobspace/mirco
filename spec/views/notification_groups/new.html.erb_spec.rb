require 'rails_helper'

RSpec.describe "notification_groups/new", type: :view do
  before(:each) do
    assign(:notification_group, NotificationGroup.new(
      name: "MyString"
    ))
  end

  it "renders new notification_group form" do
    render

    assert_select "form[action=?][method=?]", notification_groups_path, "post" do

      assert_select "input[name=?]", "notification_group[name]"
    end
  end
end
