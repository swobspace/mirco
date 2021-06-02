require 'rails_helper'

RSpec.describe "channels/edit", type: :view do
  before(:each) do
    @channel = assign(:channel, Channel.create!(
      server: nil,
      uid: "MyString",
      properties: ""
    ))
  end

  it "renders the edit channel form" do
    render

    assert_select "form[action=?][method=?]", channel_path(@channel), "post" do

      assert_select "input[name=?]", "channel[server_id]"

      assert_select "input[name=?]", "channel[uid]"

      assert_select "input[name=?]", "channel[properties]"
    end
  end
end
