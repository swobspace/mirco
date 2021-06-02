require 'rails_helper'

RSpec.describe "channels/new", type: :view do
  before(:each) do
    assign(:channel, Channel.new(
      server: nil,
      uid: "MyString",
      properties: ""
    ))
  end

  it "renders new channel form" do
    render

    assert_select "form[action=?][method=?]", channels_path, "post" do

      assert_select "input[name=?]", "channel[server_id]"

      assert_select "input[name=?]", "channel[uid]"

      assert_select "input[name=?]", "channel[properties]"
    end
  end
end
